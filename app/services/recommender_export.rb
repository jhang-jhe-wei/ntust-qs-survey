# frozen_string_literal: true

class RecommenderExport
  def initialize(recommenders, category)
    @recommenders = recommenders
    @category = category
  end

  # rubocop:disable Metrics/MethodLength
  def export!
    CSV.generate do |csv|
      csv << header
      @recommenders.each do |recommender|
        csv << [
          'National Taiwan University of Science and Technology',
          recommender.title,
          recommender.first_name,
          recommender.last_name,
          recommender.job_title,
          find_department_or_industry(recommender),
          recommender.institution_name,
          recommender.location,
          recommender.email
        ]
      end
    end
  end
  # rubocop:enable Metrics/MethodLength

  private

  def header
    [
      'Source', 'Title', 'First Name', 'Last Name',
      job_title_or_position,
      department_or_industry,
      institution_or_company_name,
      'Location',
      'Email',
      'Phone (Optional)'
    ]
  end

  def job_title_or_position
    if @category == 'academic'
      'Job Title'
    else
      'Position'
    end
  end

  def department_or_industry
    if @category == 'academic'
      'Department'
    else
      'Industry'
    end
  end

  def institution_or_company_name
    if @category == 'academic'
      'Institution'
    else
      'Company Name'
    end
  end

  def find_department_or_industry(recommender)
    if @category == 'academic'
      recommender.department
    else
      recommender.industry_name
    end
  end
end
