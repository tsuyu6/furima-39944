FactoryBot.define do
  factory :order_shipping do
    post_code { "123-4567" }
    prefecture_id { Faker::Number.between(from: 1, to: 47) }
    city { Faker::Address.city }
    block_number { "1-1-1" }
    building_name {"建物名" }
    telephone_number { "000-0000-0000"}
    token {"tok_abcdefghijk00000000000000000"} 
  end
end
