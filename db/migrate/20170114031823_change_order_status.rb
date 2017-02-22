class ChangeOrderStatus < ActiveRecord::Migration[5.0]
  def change
    change_column :orders, :status, :integer
  end
end
