class ShipTime < ApplicationRecord
  SHIP_TIME_CODE_DEFAULT = '00'

  def self.default_ship_time
    # [review] こう書くと少し短く書けそうです
    # ShipTime.find_by!(shiptime_code: ShipTime::SHIP_TIME_CODE_DEFAULT)
    ShipTime.where(shiptime_code: ShipTime::SHIP_TIME_CODE_DEFAULT).first!
  end

  # [review] orderの部分はこう書くこともできます。
  # scope :active_list, -> { order(shiptime_code: :asc) }
  scope :active_list, -> { order('shiptime_code asc') }
end
