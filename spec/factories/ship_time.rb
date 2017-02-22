FactoryGirl.define do
  factory :ship_time_01, class: ShipTime do
    shiptime_code '01'
    display_name '8時〜12時'
  end
  factory :ship_time_02, class: ShipTime do
    shiptime_code '02'
    display_name '12時〜14時'
  end
  factory :ship_time_03, class: ShipTime do
    shiptime_code '03'
    display_name '14時〜16時'
  end
  factory :ship_time_04, class: ShipTime do
    shiptime_code '04'
    display_name '16時〜18時'
  end
  factory :ship_time_05, class: ShipTime do
    shiptime_code '05'
    display_name '18時〜20時'
  end
  factory :ship_time_06, class: ShipTime do
    shiptime_code '06'
    display_name '20時〜21時'
  end
  factory :ship_time_00, class: ShipTime do
    shiptime_code '00'
    display_name '未指定'
  end
end