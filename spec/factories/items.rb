FactoryBot.define do
  factory :item do
    category_id{2}  
    condition_id{6}
    shipping_charge_id{2}
    prefecture_id{14}
    item_name{"マフラー"}
    price{300}
    information{"紺色"}
    delively_day_id{4}
    association :user
    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
