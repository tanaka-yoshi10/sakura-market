FactoryGirl.define do
  factory :order_item_1, class: OrderItem do
    association :product, factory: :product_tomato, strategy: :create # 1300
    quantity 1
  end

  factory :order_item_2, class: OrderItem do
    association :product, factory: :product_nasu, strategy: :create   # 280
    quantity 2
  end

  factory :order_item_no_product, class: OrderItem do
    quantity 2
  end

  factory :order_base, class: Order do
    association :user, factory: :user_normal, strategy: :create

    trait :status_on_cart_empty do
    end

    trait :status_on_cart do
      status :on_cart
    end
    trait :status_ordered do
      status :ordered
    end

    trait :ship_address_valid do
      ship_zip_code '111-1111'
      ship_address '東京都港区麹町1-1-1'
    end

    trait :two_item do
      after(:create) do |order|
        order.order_items << create(:order_item_1, order: order)
        order.order_items << create(:order_item_2, order: order)
      end
    end

    trait :ship_address_invalid do
      ship_zip_code 'aaaa'
      ship_address '東京都港区麹町1-1-1'
    end

    factory :order_on_cart, traits: [:status_on_cart_empty]
    factory :order_on_cart_2item, traits: [:status_on_cart, :ship_address_valid, :two_item]
    factory :order_on_cart_invalid, traits: [:status_on_cart,:ship_address_invalid, :two_item]
    factory :order_ordered, traits: [:status_ordered, :ship_address_valid, :two_item]

  end

end