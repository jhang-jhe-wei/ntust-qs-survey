class Admin::RecommendersController < Admin::BaseController
  def index
    recommenders = current_user.recommenders.includes(:institution, :industry, :users).all
    # need to refactor
    @academic_recommenders = recommenders.where(industry_id: Industry.find_by_name('Academic').id)
    @industry_recommenders = recommenders.where.not(industry_id: Industry.find_by_name('Academic').id)
  end

  def new
    @recommender = Recommender.new
  end

  def create
    if params[:category] == '學術界'
      @recommender = current_user.recommenders.create(recommender_params.merge(
        industry_id: Industry.find_by_name('Academic').id
      ))
    else
      institution = Institution.find_or_create_by(name: params[:company], country_id: params[:country])
      @recommender = current_user.recommenders.create(recommender_params.merge(
        department: nil,
        institution_id: institution.id
      ))
    end

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
