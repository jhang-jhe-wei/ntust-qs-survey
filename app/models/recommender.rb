class Recommender < ApplicationRecord
  belongs_to :institution, optional: true
  belongs_to :industry, optional: true
  has_many :user_and_recommender_records
  has_many :users, :through => :user_and_recommender_records
end
