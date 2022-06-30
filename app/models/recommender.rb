# frozen_string_literal: true

class Recommender < ApplicationRecord
  belongs_to :institution, optional: true
  belongs_to :industry, optional: true
  has_many :user_and_recommender_records, dependent: :destroy
  has_many :users, through: :user_and_recommender_records
  scope :is_academic, -> { where(category: '學術界') }
  scope :is_industry, -> { where(category: '產業界') }
  validates :category, inclusion: { in: %w[學術界 產業界] }
end
