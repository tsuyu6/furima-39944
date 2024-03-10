FactoryBot.define do
  factory :message do
    content {Faker::Lorem.sentence}
    association :user
    association :room
  end
end

  # after(:build) do |message|
    #   message.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')

