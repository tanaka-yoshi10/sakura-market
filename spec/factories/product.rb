FactoryGirl.define do
  factory :product_tomato, class: Product do
    name '長野産とまと(6個入り)'
    price 1300
    display_flag true
  end
  factory :product_nasu, class: Product do
    name '千葉産なす(2個)'
    price 280
    display_flag true
  end
end