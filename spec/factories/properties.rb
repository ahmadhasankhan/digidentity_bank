FactoryBot.define do
  factory :property do
    title { "MyString" }
    price { 1.5 }
    address { "MyText" }
    total_area { 1.5 }
    status { 1 }
    lat { 1.5 }
    long { 1.5 }
  end
end
