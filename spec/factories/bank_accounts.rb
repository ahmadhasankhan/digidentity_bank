FactoryBot.define do
  factory :bank_account do
    account_number { "MyString" }
    account_type { 1 }
    user { nil }
    balance { "9.99" }
  end
end
