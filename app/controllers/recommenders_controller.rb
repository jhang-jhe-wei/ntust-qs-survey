class RecommendersController < ApplicationController
  before_action :authenticate_user!

  def index
    @recommenders = Recommender.includes(:institution, :industry, :users).all
  end

  def new
    @recommender = Recommender.new
  end

  def create
    @recommender = Recommender.new(recommender_params)
    if @recommender.save
      redirect_to recommenders_url, notice: "推薦者已建立"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
  def recommender_params
    params.require(:recommender).permit(:title, :first_name, :last_name, :job_title, :department, :institution_id, :industry_id)
  end
end
