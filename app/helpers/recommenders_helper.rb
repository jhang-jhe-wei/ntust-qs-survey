module RecommendersHelper
  def all_industries_options
    options_for_select(Industry.all.map{ |industry| [industry.name, industry.id] })
  end

  def all_institutions_options
    options_for_select(Institution.all.map{ |institution| [institution.name, institution.id] })
  end

end
