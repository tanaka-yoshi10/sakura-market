class AddCodChargeToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :cod_charge, :decimal
  end
end
