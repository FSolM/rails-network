# frozen_string_literal: true

require 'factory_bot'

FactoryBot.define do
  rand_string = (0..50).map { rand(65..90).chr }.join
  email = "post_random_#{rand_string.downcase}@email.com"

  factory :post do
    content { 'Same boring content :(' }
    association :author, factory: :user, email: email
  end
end
