class AddColumnToShipTimes < ActiveRecord::Migration[5.0]
  def change
    add_column :ship_times, :description, :string
  end
end
