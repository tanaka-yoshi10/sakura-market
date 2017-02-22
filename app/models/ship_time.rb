class ShipTime < ApplicationRecord
  SHIP_TIME_CODE_DEFAULT = '00'

  def self.default_ship_time
    ShipTime.where(shiptime_code: ShipTime::SHIP_TIME_CODE_DEFAULT).first!
  end

  scope :active_list, -> { order('shiptime_code asc') }
end
