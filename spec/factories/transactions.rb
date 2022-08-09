FactoryBot.define do
  factory :transaction do
    reference_number { "MyString" }
    amount { "9.99" }
    transaction_type { 1 }
    account { nil }
    receiver { nil }
    status { 0 }
    message { "MyMessage" }
  end
end
