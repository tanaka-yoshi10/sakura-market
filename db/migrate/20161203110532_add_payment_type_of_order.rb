class AddPaymentTypeOfOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :payment_type, :string
  end
end
