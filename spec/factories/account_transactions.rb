FactoryBot.define do
  factory :account_transaction do
    transaction_number { "MyString" }
    amount { "9.99" }
    transaction_type { 1 }
    bank_account { nil }
  end
end
