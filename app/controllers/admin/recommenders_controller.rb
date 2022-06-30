# frozen_string_literal: true

module Admin
  class RecommendersController < Admin::BaseController
    def index
      @department = NtustDepartment.find_by(id: params[:department_id]) || current_user.department
      authorize @department
      @recommenders = @department.visible_recommenders
    end

    def new
      @recommender = Recommender.new
    end

    def create
      @recommender = current_user.recommenders.create(recommender_params)

      if @recommender.errors.empty?
        redirect_to admin_recommenders_url, notice: '推薦者已建立'
      else
        render :new, status: :unprocessable_entity
      end
    end

    private

    def recommender_params
      if base_params[:category] == '產業界'
        institution = Institution.find_or_create_by(name: params[:company], country_id: params[:country])
        return base_params.merge!(
          department: nil,
          institution_id: institution.id,
          industry_id: params[:recommender][:industry_id]
        )
      end
      base_params
    end

    def base_params
      params.require(:recommender).permit(:title, :first_name, :last_name, :job_title, :department, :institution_id,
                                          :provider_email, :provider_name, :email, :category)
    end
  end
end
