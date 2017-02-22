require 'rails_helper'

describe ShipTime do
  let!(:cod_charge_01) { create(:cod_charge_01) }
  let!(:cod_charge_02) { create(:cod_charge_02) }
  let!(:cod_charge_03) { create(:cod_charge_03) }
  let!(:cod_charge_04) { create(:cod_charge_04) }

  describe 'cod_charge_from_amountメソッド' do
    describe '0-10000' do
      it '最小値:0' do
        expect(CodCharge.cod_charge_from_amount(0).charge).to eq(300)
      end
      it '最大値:9999' do
        expect(CodCharge.cod_charge_from_amount(9999).charge).to eq(300)
      end
    end
    describe '10000-30000' do
      it '最小値:10000' do
        expect(CodCharge.cod_charge_from_amount(10000).charge).to eq(400)
      end
      it '最大値:29999' do
        expect(CodCharge.cod_charge_from_amount(29999).charge).to eq(400)
      end
    end
    describe '30000-100000' do
      it '最小値:30000' do
        expect(CodCharge.cod_charge_from_amount(30000).charge).to eq(600)
      end
      it '最大値:99999' do
        expect(CodCharge.cod_charge_from_amount(99999).charge).to eq(600)
      end
    end
    describe '100000-' do
      it '最小値:100000' do
        expect(CodCharge.cod_charge_from_amount(100000).charge).to eq(1000)
      end
      it 'それ以上の値:9999999998' do
        expect(CodCharge.cod_charge_from_amount(9999999998).charge).to eq(1000)
      end
    end
  end

end