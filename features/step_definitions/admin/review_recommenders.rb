# frozen_string_literal: true

Given('there are {int} {string} recommenders belong to {string} user') do |quantity, category, department|
  quantity.times do
    user = NtustDepartment.find_by(name: department).users.first
    user.recommenders.create!(attributes_for(:recommender, category:))
  end
end
