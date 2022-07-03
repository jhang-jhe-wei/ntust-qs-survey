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

    def share; end

    def upload
    end

    def upload_excel
      xlsx = Roo::Excelx.new(params[:excel])
      recommenders = []
      ActiveRecord::Base.transaction do
        recommenders = Recommender.save_excel_data(xlsx)
        recommenders.each {|rem| current_user.recommenders << rem }
      end
      success_count = Recommender.where(id: recommenders.pluck(:id)).is_done.count
      pending_count = Recommender.where(id: recommenders.pluck(:id)).is_pending.count
      redirect_to upload_admin_recommenders_path, notice: "成功匯入 #{success_count} 筆", alert:  "待修正 #{pending_count} 筆"
    end

    def download_template_excel
      send_file Rails.root.join("public/qs-survey-recommenders-template.xlsx"), type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
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
