class AddColumnToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :subtotal, :decimal
  end
end
