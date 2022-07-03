# frozen_string_literal: true

Then('I can ensure {string} user has {int} recommenders') do |department_name, count|
  department = NtustDepartment.find_by(name: department_name)
  recommenders = department.users.first.recommenders
  expect(recommenders.count).to eq(count)
end
