class UserAndRecommenderRecord < ApplicationRecord
  belongs_to :user
  belongs_to :recommender
end
