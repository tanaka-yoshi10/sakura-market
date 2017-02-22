class ChangeOrderShipDateToDate < ActiveRecord::Migration[5.0]
  def change
    change_column :orders, :ship_date, :date
  end
end
