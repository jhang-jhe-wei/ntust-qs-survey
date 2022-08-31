# frozen_string_literal: true

module RecommendersHelper
  def all_industries_options(default = 0)
    options_for_select(Industry.all.map { |industry| [industry.name, industry.id] }, default)
  end

  def all_institutions_options(default = 0)
    options_for_select(Institution.all.map { |institution| [institution.name, institution.id] }, default)
  end

  def all_countries_options(default = 0)
    options_for_select(Country.all.map { |country| [country.name, country.id] }, default)
  end

  def all_categories_options(default = '學術界')
    options_for_select([
                         %w[學術界 學術界],
                         %w[產業界 產業界]
                       ], default)
  end

  def all_departments_options(department, default = 0)
    options_for_select(department.self_or_departments.all.map do |department_|
                         [department_.name, department_.id]
                       end, default)
  end
end
