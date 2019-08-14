FactoryBot.define do
  factory :post do 
    content { "Same boring content :(" }
    association :author, factory: :user, email: 'thisemailisdifferent@email.com'
  end
end
