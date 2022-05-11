class RecommendersController < ApplicationController
  before_action :authenticate_user!

  def index
    @recommenders = Recommender.includes(:institution, :industry, :users).all
  end
  end
end
