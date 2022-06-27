class Admin::RecommendersController < Admin::BaseController
  def index
    @recommenders = Recommender.includes(:institution, :industry, :users).all
  end

  def new
    @recommender = Recommender.new
  end

  def create
    @recommender = current_user.recommenders.create(recommender_params)
    if @recommender.errors.empty?
      redirect_to admin_recommenders_url, notice: "推薦者已建立"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
  def recommender_params
    params.require(:recommender).permit(:title, :first_name, :last_name, :job_title, :department, :institution_id, :industry_id, :provider_email, :provider_name, :email)
  end
end
