require 'factory_bot'

FactoryBot.define do 
  rand_string = (0..50).map { (65 + rand(26)).chr }.join
  email = "user_random_#{rand_string.downcase}@email.com"

  factory :user do |f|
    f.email {  email }
    f.password { "supersecret123" }
    f.password_confirmation { "supersecret123" }
    f.image_link { "www.myexampleimg.com" }
    f.name { "Jane Doe" }
    f.birth_day { Date.current() }
    f.bio { "Pretty regular :c" }
  end
end