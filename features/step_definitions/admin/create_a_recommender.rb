# frozen_string_literal: true

Then('I can ensure the recommender has these attributes') do |table|
  @recommender = @user.recommenders.first
  table.hashes.each do |hash|
    expect(@recommender[hash['field']]).to eq(hash['value'])
  end
end

Then("I can ensure the recommender's {string} is {string}") do |attribute, text|
  expect(@recommender.send(attribute).name).to eq(text)
end
