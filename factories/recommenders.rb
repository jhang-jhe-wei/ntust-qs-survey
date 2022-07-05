# frozen_string_literal: true

FactoryBot.define do
  factory :recommender do
    title { 'Dr.' }
    first_name { 'John' }
    last_name { 'Doe' }
    sequence(:email) { |n| "person#{n}@example.com" }
    provider_name { 'provider' }
    provider_email { 'provider@gmail.com' }
    job_title { 'Professor' }
    department { 'HR' }
    institution_id { Institution.first.id }
    industry_id { Industry.first.id }
  end
end
