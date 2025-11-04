FactoryBot.define do
  factory :order do
    postal_code { "MyString" }
    prefecture_id { 1 }
    city { "MyString" }
    address { "MyString" }
    detail_address { "MyString" }
    phone { "MyString" }
    purchase_management { nil }
  end
end
