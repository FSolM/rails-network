# frozen_string_literal: true

FactoryBot.define do
  factory :reaction do
    reaction_type { 0 }
    association :user, factory: :user
    association :post, factory: :post
  end
end
