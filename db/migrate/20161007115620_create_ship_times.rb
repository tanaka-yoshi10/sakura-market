class CreateShipTimes < ActiveRecord::Migration[5.0]
  def change
    create_table :ship_times do |t|
      t.string :shiptime_code
      t.string :display_name

      t.timestamps
    end
  end
end
