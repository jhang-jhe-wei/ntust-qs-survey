# frozen_string_literal: true

Given('there are {int} pending recommenders belong to {string} user') do |quantity, department_name|
  department = NtustDepartment.find_by(name: department_name)
  quantity.times do
    department.users.first.recommenders.create!(attributes_for(:recommender, category: '產業界', title: nil))
  end
end
