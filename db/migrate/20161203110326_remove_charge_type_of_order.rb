class RemoveChargeTypeOfOrder < ActiveRecord::Migration[5.0]
  def change
    remove_column :orders, :charge_type
  end
end
