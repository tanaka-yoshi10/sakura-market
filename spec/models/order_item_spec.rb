require 'rails_helper'

describe OrderItem do

  let!(:ship_time) { create(:ship_time_00) }
  let!(:cod_charge_01) { create(:cod_charge_01) }
  let!(:cod_charge_02) { create(:cod_charge_02) }
  let!(:cod_charge_03) { create(:cod_charge_03) }
  let!(:cod_charge_04) { create(:cod_charge_04) }
  let!(:user) {create(:user)}
  let!(:product_tomato) {create(:product_tomato)}

  let(:order_on_cart) { create(:order_on_cart) }

  describe '正常値' do
    context '数量1個' do
      let(:order_item) { build(:order_item_1, order: order_on_cart)}
      it '正常と判定される' do
        order_item.valid?
        expect(order_item).to be_valid
      end
    end

    context 'unit_price(保存前)' do
      let(:order_item) { build(:order_item_2, order: order_on_cart)}
      it '合計金額が計算される' do
        expect(order_item.unit_price).to eq(280)
      end
    end

    context 'unit_price(保存済)' do
      let(:order_item) { create(:order_item_2, order: order_on_cart)}
      it '合計金額が計算される' do
        expect(order_item.unit_price).to eq(280)
      end
    end
    context 'total_price(保存前)' do
      let(:order_item) { build(:order_item_2, order: order_on_cart)}
      it '合計金額が計算される' do
        expect(order_item.total_price).to eq(560)
      end
    end
    context 'total_price(保存済)' do
      let(:order_item) { create(:order_item_2, order: order_on_cart)}
      it '合計金額が計算される' do
        expect(order_item.total_price).to eq(560)
      end
    end
  end

  describe 'バリデーションエラー' do
    context '商品未設定' do
      let(:order_item) { build(:order_item_no_product)}
      it '未設定でバリデーションエラーになる' do
        is_expected.to validate_presence_of(:product)
          .with_message("を入力してください")
      end
    end
    context 'order未設定' do
      let(:order_item) { build(:order_item_1)}
      it '未設定でバリデーションエラーとなる' do
        order_item.valid?
        is_expected.to validate_presence_of(:order)
                           .with_message("を入力してください")
      end
    end
    context '数量未設定' do
      let(:order_item) { build(:order_item_1, quantity: nil)}
      it '未設定でバリデーションエラーになる' do
        is_expected.to validate_presence_of(:quantity)
                           .with_message("を入力してください")
      end
    end
    context '数量が数値以外' do
      let(:order_item) { build(:order_item_1, quantity: 'xxx')}
      it 'バリデーションエラーになる' do
        is_expected.to validate_numericality_of(:quantity)
                           .with_message("は数値で入力してください")
      end
    end
    context '数量がマイナス値' do
      let(:order_item) { build(:order_item_1, quantity: -1)}
      it 'バリデーションエラーになる' do
        is_expected.to validate_numericality_of(:quantity)
                           .with_message("は数値で入力してください")
      end
    end
  end

end