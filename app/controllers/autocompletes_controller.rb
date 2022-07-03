# frozen_string_literal: true

class AutocompletesController < ApplicationController
  def company_name
    render json: Institution.where('name LIKE ?', "%#{params[:q]}%").all.pluck(:name).uniq
  end
end
