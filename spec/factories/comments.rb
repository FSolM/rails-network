# frozen_string_literal: true

require 'factory_bot'

FactoryBot.define do
  rand_string = (0..50).map { rand(65..90).chr }.join
  email = "comment_random_#{rand_string.downcase}@email.com"

  factory :comment do
    content { 'Comment created in a laboratory' }
    association :author, factory: :user, email: email
    association :post, factory: :post
  end
end
