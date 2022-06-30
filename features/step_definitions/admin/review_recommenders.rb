Given('there are {int} {string} recommenders belong to {string} user') do |quantity, category, department|
  quantity.times do
    user = NtustDepartment.find_by_name(department).users.first
    user.recommenders.create!(attributes_for(:recommender, category: category))
  end
end

