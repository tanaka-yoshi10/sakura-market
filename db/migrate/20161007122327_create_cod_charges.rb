class CreateCodCharges < ActiveRecord::Migration[5.0]
  def change
    create_table :cod_charges do |t|
      t.string :cod_charge_code
      t.integer :charge
      t.integer :start_amount
      t.integer :end_amount

      t.timestamps
    end
  end
end
