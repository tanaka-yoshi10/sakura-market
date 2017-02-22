class ChangeOrderShipDate < ActiveRecord::Migration[5.0]
  def change
    change_column :orders, :ship_date, :datetime
  end
end
