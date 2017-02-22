class RemoveTestOfProducts < ActiveRecord::Migration[5.0]
  def change
    remove_column :products, :test
  end
end
