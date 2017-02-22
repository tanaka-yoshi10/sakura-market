class RemoveUserOfCartItems < ActiveRecord::Migration[5.0]
  def change
    remove_foreign_key :cart_items, :users
    remove_index :cart_items, :user_id
    remove_column :cart_items, :user_id
  end
end
