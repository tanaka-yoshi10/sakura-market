class CodCharge < ApplicationRecord

  def self.cod_charge_from_amount(subtotal)
    CodCharge.where("start_amount <= ? AND ? < end_amount", subtotal, subtotal).first!()
  end

end
