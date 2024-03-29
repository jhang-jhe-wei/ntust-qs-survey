# frozen_string_literal: true

Given('there is a user belongs to {string} logged in') do |department_name|
  department = NtustDepartment.find_by(name: department_name)
  email = 'user@example.com'
  password = '123456+999'

  @user = User.create!(email:,
                       password:,
                       ntust_department_id: department.id)

  visit new_user_session_path
  fill_in 'user_email', with: email
  fill_in 'user_password', with: password
  click_on 'commit'
  expect(page).to have_text('成功登入了。')
end

Given('there are some users belong to {string}') do |department_name, table|
  department = NtustDepartment.find_by(name: department_name)
  table.hashes.each do |attrs|
    User.create! attrs.merge(
      ntust_department_id: department.id
    )
  end
end

Given('there are {int} users belong to {string}') do |_quantity, department_name|
  department = NtustDepartment.find_by(name: department_name)
  create_list(:user, 3, ntust_department_id: department.id)
end

When('I visit {string}') do |path|
  visit path
end

When('I open landing page') do
  visit root_path
end

Then('I can see {string}') do |text|
  expect(page).to have_text(text)
end

Then('I can not see {string}') do |text|
  expect(page).not_to have_text(text)
end

When('I click {string}') do |label|
  click_link_or_button(label)
end

When('I click {string} with confirmation') do |label|
  accept_confirm do
    click_link_or_button(label)
  end
end

When('I select {string} as {string}') do |label, option|
  select option, from: label
end

When('I fill {string} form') do |form_name, table|
  table.hashes.each do |row|
    fill_in("#{form_name}_#{row['field']}", with: row['value'])
  end
end

When('I fill {string} with {string}') do |input, text|
  fill_in(input, with: text)
end

When('I attach {string} in {string}') do |file_name, label|
  attach_file(label, Rails.root.join("fixtures/#{file_name}"))
end
