require 'factory_bot'

FactoryBot.define do

  factory :user do |f|
    f.email { "jane_doe@example.com" }
    f.password { "supersecret123" }
    f.password_confirmation { "supersecret123" }
    f.image_link { "www.myexampleimg.com" }
    f.name { "Jane Doe" }
    f.birth_day { Date.current() }
    f.bio { "Pretty regular :c" }
  end

end