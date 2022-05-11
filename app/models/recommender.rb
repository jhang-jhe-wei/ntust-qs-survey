class Recommender < ApplicationRecord
  belongs_to :institution
  belongs_to :industry
  has_many :user_and_recommender_records
  has_many :users, :through => :user_and_recommender_records

end
