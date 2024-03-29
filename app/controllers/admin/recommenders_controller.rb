# frozen_string_literal: true

module Admin
  class RecommendersController < Admin::BaseController
    before_action :set_recommender, only: %i[edit update destroy]

    def index
      @department = NtustDepartment.find_by(id: params[:department_id]) || current_user.department
      authorize @department
      @recommenders = @department.visible_recommenders.is_done.order_by_update_at
    end

    def new
      @recommender = Recommender.new
      @department = current_user.department
    end

    def create
      @recommender = current_user.recommenders.create(recommender_params)

      if @recommender.errors.empty?
        redirect_to admin_recommenders_url, notice: '推薦者已建立'
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
      @department = current_user.department
    end

    def update
      @recommender.update(recommender_params)

      if @recommender.errors.empty?
        redirect_to upload_admin_recommenders_url, notice: '已更新推薦者'
      else
        render :new, status: :unprocessable_entity
      end
    end

    def destroy
      @recommender.destroy
      redirect_back_or_to admin_recommenders_url, notice: '已成功刪除該推薦人'
    end

    def share; end

    def upload
      @pending_recommenders = current_user.department.visible_recommenders.is_pending
    end

    def upload_excel
      xlsx = Roo::Excelx.new(params[:excel])
      recommenders = []
      ActiveRecord::Base.transaction do
        recommenders = Recommender.save_excel_data(xlsx)
        current_user.recommenders << recommenders
      end
      query = Recommender.where(id: recommenders.pluck(:id))
      redirect_to upload_admin_recommenders_path, notice: "成功匯入 #{query.is_done.count} 筆",
                                                  alert: "待修正 #{query.is_pending.count} 筆"
    end

    def download_template_excel
      send_file Rails.root.join('public/qs-survey-recommenders-template.xlsx'),
                type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
    end

    def export
      recommender = current_user.department.visible_recommenders.is_done.order_by_update_at
      @academic_recommenders = export_json(recommender.is_academic)
      @industry_recommenders = export_json(recommender.is_industry)
    end

    def export_csv
      recommenders = current_user.department.visible_recommenders.where(id: params[:ids])
      recommenders.update_all(is_committed: true, exported_at: DateTime.now) # rubocop:disable Rails/SkipsModelValidations
      send_data(
        RecommenderExport.new(recommenders, params[:category]).export!,
        filename: "#{Time.zone.today}-export.csv"
      )
    end

    private

    def recommender_params
      institution = Institution.find_or_create_by(name: params[:institution], country_id: params[:country])
      attrs = base_params.merge(institution_id: institution.id)
      if base_params[:category] == '產業界'
        attrs.merge!(
          department: nil,
          industry_id: params[:recommender][:industry_id]
        )
      end
      attrs
    end

    def base_params
      params.require(:recommender).permit(:title, :first_name, :last_name, :job_title, :department,
                                          :provider_email, :provider_name, :email, :category)
    end

    def set_recommender
      @recommender = current_user.department.visible_recommenders.find(params[:id])
    end

    def export_json(recommenders)
      recommenders.as_json(
        root: false,
        only: %i[id provider_name provider_email title first_name
                 last_name job_title department position email],
        methods: %i[committed_on provider_unit institution_name industry_name company_name location exported_on]
      )
    end
  end
end
