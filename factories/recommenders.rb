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
    institution_id { Institution.find_by(name: '臺灣科技大學').id }
  end
end
