Given('there are {int} 學術界 recommenders belong to {string} user') do |quantity, department|
  quantity.times do
    @user.recommenders.create!(attributes_for(:recommender, :academic))
  end
end

Given('there are {int} 產業界 recommenders belong to {string} user') do |quantity, department|
  quantity.times do
    @user.recommenders.create!(attributes_for(:recommender, :industry))
  end
end

