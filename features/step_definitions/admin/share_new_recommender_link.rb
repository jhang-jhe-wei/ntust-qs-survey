When('I can see new recommender link') do
  expect(page).to have_text(/https?:\/\/.*\/recommenders\/new\?user_token=#{@user.token}/)
end
