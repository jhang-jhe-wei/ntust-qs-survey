module RecommendersHelper
  def all_industries_options
    options_for_select(Industry.all.map{ |industry| [industry.name, industry.id] })
  end

  def all_institutions_options
    options_for_select(Institution.all.map{ |institution| [institution.name, institution.id] })
  end

  def all_countries_options
    options_for_select(Country.all.map{ |country| [country.name, country.id] })
  end

  def all_categories_options
    options_for_select([
      ["學術界", "學術界"],
      ["產業界", "產業界"]
    ])
  end
end
