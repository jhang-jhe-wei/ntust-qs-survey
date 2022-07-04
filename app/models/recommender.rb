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
  validates :category, inclusion: { in: %w[學術界 產業界] }
  validates :status, inclusion: { in: %w[pending done] }
  validates :title, presence: true, unless: :pending?
  validates :first_name, presence: true, unless: :pending?
  validates :last_name, presence: true, unless: :pending?
  validates :job_title, presence: true, unless: :pending?
  validates :department, presence: true, unless: :pending_or_industry?
  validates_associated :institution, unless: :pending?
  validates_associated :industry, unless: :pending_or_academic?
  validates :email, format: { with: Devise.email_regexp, unless: :pending? }
  validates :provider_name, presence: true, unless: :pending?
  validates :provider_email, presence: true, unless: :pending?
  before_save :set_status

  def self.save_excel_data(excel)
    recommenders = []
    excel.sheet('聲譽調查提名名冊-學界').parse(header_search: ['提供此名單之教師姓名']).each do |row|
      recommenders << Recommender.create(academic_attrs(row))
    end

    excel.sheet('聲譽調查提名名冊-業界').parse(header_search: ['提供此名單之教師姓名']).each do |row|
      recommenders << Recommender.create(industry_attrs(row))
    end
    recommenders
  end

  def pending_or_academic?
    pending? || academic?
  end

  def pending_or_industry?
    pending? || !academic?
  end

  def pending?
    status == 'pending'
  end

  def academic?
    category == '學術界'
  end

  private

  def set_status
    self.status = 'done'
    self.status = 'pending' if invalid?
  end

  class << self
    def academic_attrs(row)
      institution_id = Institution.find_by(name: row["Institution Name\n所屬學校/機構名"]).id
      common_attrs(row).merge(
        institution_id: institution_id,
        department: row["Department\n所屬系所/單位名"],
        category: '學術界'
      )
    end

    def industry_attrs(row)
      country_id = Country.find_by(name: row["Location\n所處國別"])
      institution_id = Institution.find_or_create_by(name: row["Company Name\n所屬公司/機構名"],
                                                     country_id:).id
      industry_id = Industry.find_by(name: row["Industry\n產業別(下拉式選單)"])
      common_attrs(row).merge(
        institution_id: institution_id,
        industry_id: industry_id,
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
