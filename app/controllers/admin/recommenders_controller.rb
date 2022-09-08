# frozen_string_literal: true

module Admin
  class RecommendersController < Admin::BaseController
    before_action :set_recommender, only: %i[edit update]

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
      @academic_recommenders = current_user.department.visible_recommenders.is_not_committed.is_done.is_academic.order_by_update_at.as_json(
        root: false,
        only: %i[id title first_name last_name job_title department email],
        methods: %i[institution_name location]
      )

      @industry_recommenders = current_user.department.visible_recommenders.is_not_committed.is_done.is_industry.order_by_update_at.as_json(
        root: false,
        only: %i[id title first_name last_name position email],
        methods: %i[industry_name company_name location]
      )

    end

    def export_csv
      @recommenders = current_user.department.visible_recommenders.where(id: params[:ids])
      csv_string = CSV.generate do |csv|
        if params[:category] == "academic"
          csv << ['Source', 'Title', 'First Name', 'Last Name',
                  'Job Title', 'Department', 'Institution', 'Location', 'Email', 'Phone (Optional)']
          @recommenders.each do |recommender|
            csv << [
              'National Taiwan University of Science and Technology',
              recommender.title,
              recommender.first_name,
              recommender.last_name,
              recommender.job_title,
              recommender.department,
              recommender.institution_name,
              recommender.location,
              recommender.email
            ]
          end
        else

          csv << ['Source', 'Title', 'First Name', 'Last Name',
                  'Position', 'Industry', 'Company Name', 'Location', 'Email', 'Phone (Optional)']
          @recommenders.each do |recommender|
            csv << [
              'National Taiwan University of Science and Technology',
              recommender.title,
              recommender.first_name,
              recommender.last_name,
              recommender.job_title,
              recommender.industry_name,
              recommender.institution_name,
              recommender.location,
              recommender.email
            ]
          end
        end
      end
      @recommenders.update_all(is_committed: true)
      send_data csv_string, filename: "#{Time.zone.today}-export.csv"
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

    def set_recommender
      @recommender = current_user.department.visible_recommenders.find(params[:id])
    end
  end
end
