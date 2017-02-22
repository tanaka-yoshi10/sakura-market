require 'rails_helper'

describe Order do

  let!(:ship_time) { create(:ship_time_00) }
  let!(:cod_charge_01) { create(:cod_charge_01) }
  let!(:cod_charge_02) { create(:cod_charge_02) }
  let!(:cod_charge_03) { create(:cod_charge_03) }
  let!(:cod_charge_04) { create(:cod_charge_04) }
  let!(:user) {create(:user)}

  describe '正常の状態' do
    context 'カートの初期状態' do
      let(:order) { build(:order_on_cart) }
      it '何も設定されてなくても有効' do
        order.valid?
        expect(order).to be_valid
      end
    end
    context 'カート内で商品追加' do
      let(:order) { build(:order_on_cart_2item)}
      it '明細が2件,配達先設定' do
        order.valid?
        expect(order).to be_valid
      end
    end
  end

  describe 'subtotalメソッド' do
    context '明細2件' do
      let(:order) { create(:order_on_cart_2item)}
      it '明細2件の合計金額が設定されていること' do
        expect(order.subtotal).to eq(1860)
      end
    end
    context '明細0件' do
      let(:order) { create(:order_on_cart)}
      it '0円に設定されていること' do
        expect(order.subtotal).to eq(0)
      end
    end
  end

  describe 'shipping_charge' do
    context '明細2件' do
      let(:order) { create(:order_on_cart_2item)}
      it '明細2件の合計金額が設定されていること' do
        expect(order.shipping_charge).to eq(600)
      end
    end
    context '明細0件' do
      let(:order) { create(:order_on_cart)}
      it '0円に設定されていること' do
        expect(order.charge_total).to eq(0)
      end
    end
  end

  describe 'cod_charge' do
    context '明細2件' do
      let(:order) { create(:order_on_cart_2item)}
      it '明細2件の合計金額が設定されていること' do
        expect(order.cod_charge).to eq(300)
      end
    end
    context '明細0件' do
      let(:order) { create(:order_on_cart)}
      it '0円に設定されていること' do
        expect(order.cod_charge).to eq(0)
      end
    end
  end

  describe 'charge_total' do
    context '明細2件' do
      let(:order) { create(:order_on_cart_2item)}
      it '明細2件の合計金額が設定されていること' do
        expect(order.charge_total).to eq(900)
      end
    end
    context '明細0件' do
      let(:order) { create(:order_on_cart)}
      it '0円に設定されていること' do
        expect(order.charge_total).to eq(0)
      end
    end
  end

  describe 'total' do
    context '明細2件' do
      let(:order) { create(:order_on_cart_2item)}
      it '明細2件の合計金額が設定されていること' do
        expect(order.total).to eq(2760)
      end
    end
    context '明細0件' do
      let(:order) { create(:order_on_cart)}
      it '0円に設定されていること' do
        expect(order.total).to eq(0)
      end
    end
  end

  describe 'confirmメソッド' do
    context '成功' do
      let(:order) { create(:order_on_cart_2item)}
      it '明細が１件以上あり,郵便番号、住所が入力されているデータは有効' do
        expect(order.confirm).to be_truthy
      end
    end
    context 'バリデーションエラー（明細なし）' do
      let(:order) { create(:order_on_cart)}
      it '明細が0件' do
        expect(order.confirm).to be_falsey
      end
    end
    context 'バリデーションエラー（お届け先なし）' do
      let(:order) { create(:order_on_cart, ship_address: '')}
      it 'お届け先未設定' do
        expect(order.confirm).to be_falsey
      end
    end
    context 'バリデーションエラー（お届け先なし）' do
      let(:order) { create(:order_on_cart, ship_zip_code: '')}
      it '郵便番号未設定' do
        expect(order.confirm).to be_falsey
      end
    end
    context '正常（お届け先なしだが、ユーザにあり）' do
      let!(:user_a) { create(:user_1_has_address) }
      let(:order) { create(:order_on_cart, ship_zip_code: '', ship_address: '', user: user_a )}
      it '郵便番号未設定' do
        expect(order.confirm).to be_falsey
      end
    end
  end

end