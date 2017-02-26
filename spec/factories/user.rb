FactoryGirl.define do
  factory :user do
    name 'test'
    email 'test@email.com'
    tel '03-1111-1111'
    #password_digest '$2a$10$BH.IQxzd3kEWbHAuHDEWgedl2XW/2zcSV82L0VVuU6DYZlBri77D2'
    password 'test'

    trait :normal do
      admin_flag false
    end

    trait :admins do
      email 'admin@mail.co.jp'
      password 'admin'
      admin_flag true
    end

    trait :user_1 do
      name 'test1'
    end

    trait :user_2 do
      name 'test2'
    end

    trait :has_address do
      after(:create) do |user|
        user.address = build(:address)
        user.save
      end
    end

    factory :user_normal, traits: [:normal]
    factory :user_admin, traits: [:admins]
    factory :user_1, traits: [:user_1]
    factory :user_2, traits: [:user_2]
    factory :user_1_has_address, traits: [:user_1, :has_address]
  end
end