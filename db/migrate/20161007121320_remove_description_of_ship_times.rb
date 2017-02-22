class RemoveDescriptionOfShipTimes < ActiveRecord::Migration[5.0]
  def change
    remove_column :ship_times, :description
  end
end
