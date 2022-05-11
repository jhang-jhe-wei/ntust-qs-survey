class Recommender < ApplicationRecord
  has_one :institution
  has_one :industry
  has_many :users, :through => :user_and_recommender_records

end
