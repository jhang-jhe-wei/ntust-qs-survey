# frozen_string_literal: true

class InstitutionsController < ApplicationController
  def index
    render json: Institution.all.pluck(:name).uniq
  end
end
