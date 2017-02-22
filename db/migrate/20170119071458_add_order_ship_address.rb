class AddOrderShipAddress < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :ship_zipc_ode, :string
    add_column :orders, :ship_address, :string
  end
end
