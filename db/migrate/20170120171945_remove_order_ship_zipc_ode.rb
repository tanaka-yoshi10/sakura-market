class RemoveOrderShipZipcOde < ActiveRecord::Migration[5.0]
  def change
    remove_column :orders, :ship_zipc_ode
  end
end
