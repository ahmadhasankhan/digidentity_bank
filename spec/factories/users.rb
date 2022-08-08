FactoryBot.define do
  factory :user do
    first_name { 'FirstName' }
    sequence(:last_name) { |n| "User #{n}" }
    telephone { '+31654321000' }
    sequence(:username) { |n| "user#{n}" }
    sequence(:email) { |n| "user#{n}@gresb.com" }
    password { 'SomePassword' }
  end
end
