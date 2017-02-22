class AddColumnToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :admin_flag, :boolean
  end
end
