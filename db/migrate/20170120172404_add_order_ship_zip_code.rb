class AddOrderShipZipCode < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :ship_zip_code, :string
  end
end
