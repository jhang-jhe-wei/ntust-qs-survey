# frozen_string_literal: true

Given('there are {int} {string} recommenders belong to {string} user') do |quantity, category, department|
  quantity.times do
    user = NtustDepartment.find_by(name: department).users.first
    user.recommenders.create!(attributes_for(:recommender, category: category))
  end
end

Then('I can see {string} select as {string}') do |selector_id, text|
  expect(find("select##{selector_id}").find('option[selected]').text).to eq(text)
end
