# frozen_string_literal: true

class Recommender < ApplicationRecord
  belongs_to :institution, optional: true
  belongs_to :industry, optional: true
  has_many :user_and_recommender_records, dependent: :destroy
  has_many :users, through: :user_and_recommender_records
  scope :is_academic, -> { where(category: '學術界') }
  scope :is_industry, -> { where(category: '產業界') }
  scope :is_pending, -> { where(status: 'pending') }
  scope :is_done, -> { where(status: 'done') }
  scope :order_by_update_at, -> { order(updated_at: :desc) }
  validates :category, inclusion: { in: %w[學術界 產業界] }
  validates :status, inclusion: { in: %w[pending done] }
  validates :title, presence: true, format: { with: /\A[A-Za-z0-9. ,_-]*\z/, message: '限以英文 (半形) 填入，並勿填寫如É、Ÿ等特殊字元。' }
  validates :first_name, presence: true,
                         format: { with: /\A[A-Za-z0-9. ,_-]*\z/, message: '限以英文 (半形) 填入，並勿填寫如É、Ÿ等特殊字元。' }
  validates :last_name, presence: true,
                        format: { with: /\A[A-Za-z0-9. ,_-]*\z/, message: '限以英文 (半形) 填入，並勿填寫如É、Ÿ等特殊字元。' }
  validates :job_title, presence: true,
                        format: { with: /\A[A-Za-z0-9. ,_-]*\z/, message: '限以英文 (半形) 填入，並勿填寫如É、Ÿ等特殊字元。' }
  validates :department, presence: true, if: :academic?,
                         format: { with: /\A[A-Za-z0-9. ,_-]*\z/, message: '限以英文 (半形) 填入，並勿填寫如É、Ÿ等特殊字元。' }
  validates_associated :institution
  validates_associated :industry, if: :industry?
  validates :institution_id, presence: true
  validates :industry_id, presence: true, if: :industry?
  validates :email, format: { with: Devise.email_regexp }
  validates :provider_name, presence: true
  validates :provider_email, presence: true
  after_validation :set_status

  class << self
    def save_excel_data(excel)
      recommenders = []
      excel.sheet('聲譽調查提名名冊-學界').parse(header_search: ['提供此名單之教師姓名']).each do |row|
        recommenders << create_or_set_pending_create(academic_attrs(row))
      end

      excel.sheet('聲譽調查提名名冊-業界').parse(header_search: ['提供此名單之教師姓名']).each do |row|
        recommenders << create_or_set_pending_create(industry_attrs(row))
      end
      recommenders
    end

    def create_or_set_pending_create(attrs)
      recommender = Recommender.new(attrs)
      recommender.status = 'pending' if recommender.invalid?
      recommender.save(validate: false)
      recommender
    end
  end

  def pending?
    status == 'pending'
  end

  def academic?
    category == '學術界'
  end

  def industry?
    category == '產業界'
  end

  private

  def set_status
    return false if errors.any?

    self.status = 'done'
  end
  class << self
    def academic_attrs(row)
      institution_id = Institution.find_by(name: row["Institution Name\n所屬學校/機構名"])&.id
      common_attrs(row).merge(
        institution_id:,
        department: row["Department\n所屬系所/單位名"],
        category: '學術界'
      )
    end

    def industry_attrs(row)
      country_id = Country.find_by(name: row["Location\n所處國別"])&.id
      institution_id = Institution.find_or_create_by(name: row["Company Name\n所屬公司/機構名"],
                                                     country_id:)&.id
      industry_id = Industry.find_by(name: row["Industry\n產業別(下拉式選單)"]&.strip)&.id
      common_attrs(row).merge(
        institution_id:,
        industry_id:,
        category: '產業界'
      )
    end

    def common_attrs(row)
      {
        provider_name: row['提供此名單之教師姓名'],
        provider_email: row['提供此名單提供之教師通訊電郵'],
        title: row["Title\n稱謂"],
        first_name: row["First Name\n名字"],
        last_name: row["Last Name\n姓氏"],
        job_title: row["Position\n職稱"],
        email: row["Email\n通訊電郵"]
      }
    end
  end
end
