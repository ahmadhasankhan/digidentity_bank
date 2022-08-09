FactoryBot.define do
  factory :user do
    first_name { 'FirstName' }
    sequence(:last_name) { |n| "User #{n}" }
    mobile { '+31654321000' }
    username { Faker::Name.unique.name }
    email { Faker::Internet.email }
    password { 'SomePassword' }
  end
end
