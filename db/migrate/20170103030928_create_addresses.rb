class CreateAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :addresses do |t|
      t.string :zip_code
      t.string :prefectures
      t.string :city
      t.string :address
      t.string :address2

      t.timestamps
    end
  end
end
