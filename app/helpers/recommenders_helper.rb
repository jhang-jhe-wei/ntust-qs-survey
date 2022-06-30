# frozen_string_literal: true

module RecommendersHelper
  def all_industries_options
    options_for_select(Industry.all.map { |industry| [industry.name, industry.id] })
  end

  def all_institutions_options
    options_for_select(Institution.all.map { |institution| [institution.name, institution.id] })
  end

  def all_countries_options
    options_for_select(Country.all.map { |country| [country.name, country.id] })
  end

  def all_categories_options
    options_for_select([
                         %w[學術界 學術界],
                         %w[產業界 產業界]
                       ])
  end

  def all_departments_options(default = 0)
    options_for_select(current_user.department.departments.all.map do |department|
                         [department.name, department.id]
                       end, default)
  end
end
