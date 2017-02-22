class AddChargeTypeToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :charge_type, :string
  end
end
