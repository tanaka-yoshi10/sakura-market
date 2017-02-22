class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :name
      t.decimal :price
      t.text :description
      t.boolean :display_flag
      t.string :display_order
      t.string :integer
      t.string :image
      t.string :test

      t.timestamps
    end
  end
end
