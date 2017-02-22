class AddColumnToCartItems < ActiveRecord::Migration[5.0]
  def change
    add_column :cart_items, :price, :integer
    add_column :cart_items, :unit_price, :integer
  end
end
