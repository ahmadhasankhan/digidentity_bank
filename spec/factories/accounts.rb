FactoryBot.define do
  factory :account do
    account_number { Faker::Bank.iban }
    account_type { 1 }
    user { nil }
    balance { "9.99" }
  end
end
