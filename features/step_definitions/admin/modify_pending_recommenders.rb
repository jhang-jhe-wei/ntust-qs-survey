# frozen_string_literal: true

Given('there are {int} pending recommenders belong to {string} user') do |quantity, department_name|
  department = NtustDepartment.find_by(name: department_name)
  quantity.times do
    recommender = department.users.first.recommenders.create!(attributes_for(:recommender, category: '產業界'))
    # rubocop:disable Rails/SkipsModelValidations
    recommender.update_columns(status: 'pending')
    # rubocop:enable Rails/SkipsModelValidations
  end
end
