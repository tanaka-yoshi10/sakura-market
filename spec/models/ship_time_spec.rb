require 'rails_helper'

describe ShipTime do
  let!(:ship_time_00) { create(:ship_time_00) }
  let!(:ship_time_01) { create(:ship_time_01) }
  let!(:ship_time_02) { create(:ship_time_02) }
  let!(:ship_time_03) { create(:ship_time_03) }
  let!(:ship_time_04) { create(:ship_time_04) }
  let!(:ship_time_05) { create(:ship_time_05) }
  let!(:ship_time_06) { create(:ship_time_06) }

  describe '正常の状態' do
    it '初期値の取得' do
      expect(ShipTime.default_ship_time.shiptime_code).to eq('00')
    end
    it '一覧が取得できる' do
      expect(ShipTime.active_list.size).to eq(7)
    end
  end

end