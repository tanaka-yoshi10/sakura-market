class ChangeDatatypeDisplayOrderOfProducts < ActiveRecord::Migration[5.0]
  def change
    change_column :products, :display_order, :integer
  end
end
