# frozen_string_literal: true

class RecommendersController < ApplicationController
  def new
    @recommender = Recommender.new
    @user_token = params[:user_token]
    @department = User.find_by(token: params[:user_token]).department
  end

  def create
    @recommender = User.find_by(token: params[:user_token]).recommenders.create(recommender_params)
    if @recommender.errors.empty?
      redirect_to new_recommender_url(user_token: params[:user_token]), notice: '推薦者已建立'
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
