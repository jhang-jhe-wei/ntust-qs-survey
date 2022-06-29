# frozen_string_literal: true

FactoryBot.define do
  factory :recommender do
    title { "Dr." }
    first_name { "John" }
    last_name { "Doe" }
    sequence(:email) { |n| "person#{n}@example.com" }
    provider_name { "provider" }
    provider_email { "provider@gmail.com" }
    job_title { "Professor" }

    trait :academic do
      sequence(:department) { |n| "department#{n}" }
      industry_id { Industry.find_by_name("Academic").id }
      institution_id { Institution.find_by_name("臺灣科技大學").id }
    end

    trait :industry do
      industry_id { Industry.where.not(name: 'Academic').first.id }
      institution_id { Institution.find_by_name("臺灣科技大學").id }
    end
  end
end
