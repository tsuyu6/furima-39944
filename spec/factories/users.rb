FactoryBot.define do
  factory :user do
    nickname {'ヤーマダー'}
    email {Faker::Internet.email}
    password {"1a"+Faker::Internet.password(min_length: 6)}
    password_confirmation {password}
    family_name {'山田'}
    first_name {'太郎'}
    first_name_kana {'ヤマダ'}
    family_name_kana {'タロウ'}
    birthday {'1989-06-06'}
  end
end