class RemoveAddressOfUser < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :zip_code
    remove_column :users, :prefectures
    remove_column :users, :city
    remove_column :users, :address
  end
end
