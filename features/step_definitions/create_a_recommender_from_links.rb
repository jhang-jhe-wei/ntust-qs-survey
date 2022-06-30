When('I open the new recommender link from {string} user') do |department_name|
  department = NtustDepartment.find_by(name: department_name)
  visit new_recommender_path(user_token: department.users.first.token)
end

Then('I can ensure {string} user has these attributes recommender') do |department_name, table|
  department = NtustDepartment.find_by(name: department_name)
  recommender = department.users.first.recommenders.first
  table.hashes.each do |hash|
    expect(recommender[hash['field']]).to eq(hash['value'])
  end
end

Then('I can ensure {string} user has the recommender whose {string} is {string}') do |department_name, attribute, text|
  department = NtustDepartment.find_by(name: department_name)
  recommender = department.users.first.recommenders.first
  expect(recommender.send(attribute).name).to eq(text)
end
