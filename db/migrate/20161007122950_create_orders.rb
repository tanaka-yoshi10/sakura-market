class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.datetime :order_datetime
      t.string :status
      t.string :payment_code
      t.belongs_to :ship_time, foreign_key: true
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
