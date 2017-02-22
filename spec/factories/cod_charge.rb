FactoryGirl.define do
  factory :cod_charge_01, class: CodCharge do
    cod_charge_code '01'
    charge 300
    start_amount 0
    end_amount 10000
  end
  factory :cod_charge_02, class: CodCharge do
    cod_charge_code '02'
    charge 400
    start_amount 10000
    end_amount 30000
  end
  factory :cod_charge_03, class: CodCharge do
    cod_charge_code '03'
    charge 600
    start_amount 30000
    end_amount 100000
  end
  factory :cod_charge_04, class: CodCharge do
    cod_charge_code '04'
    charge 1000
    start_amount 100000
    end_amount 9999999999
  end
end