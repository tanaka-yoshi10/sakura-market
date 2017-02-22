class AddShippingChargeToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :shipping_charge, :decimal
  end
end
