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

  def recommender_text_field_tag(attribute, options = {})
    text_field(attribute, nil, {
      id: attribute,
      name: attribute,
      class: 'recommender-form-input',
      pattern: '[A-Za-z0-9. ,_-]*',
      title: '限以英文 (半形) 填入，並勿填寫如É、Ÿ等特殊字元。'
    }.merge(options))
  end
end
