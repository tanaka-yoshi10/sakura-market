require 'rails_helper'

describe CartsController do
  describe 'GET #show' do
    let!(:user) {
      user = create(:user_normal)
      session[:user_id] = user.id
      user
    }
    let!(:ship_time) { ShipTime.create(shiptime_code: '00', display_name: '未指定')}
    let!(:order_data) {create(:order_on_cart_2item, user_id: user.id)}
    let(:request) { get :show }

    context 'with valid attributes' do
      it "assigns the requested contact to @order" do
        request
        expect(assigns(:order)).to eq order_data
      end

      it "renders the :show template" do
        request
        expect(response).to render_template :show
      end
    end
  end

  describe 'Patch #update' do
    let!(:user) {
      user = create(:user_normal)
      session[:user_id] = user.id
      user
    }
    let!(:ship_time) { ShipTime.create(shiptime_code: '00', display_name: '未指定')}
    let!(:cod_charge_01) { create(:cod_charge_01) }
    let!(:cod_charge_02) { create(:cod_charge_02) }
    let!(:cod_charge_03) { create(:cod_charge_03) }
    let!(:cod_charge_04) { create(:cod_charge_04) }
    let(:params) { {order: attributes_for(:order_on_cart_2item, user_id: user.id) }}
    let(:request) { patch :update, params: params }

    context '正常値' do
      let!(:order_data) {create(:order_on_cart_2item, user_id: user.id)}
      it "@orderが注文済みになっていること" do
        request
        order_data.reload
        expect(order_data.status).to eq(:ordered)
      end

      it "カート画面が表示される" do
        request
        expect(response).to redirect_to cart_path
      end
    end
    context '異常値' do
      let!(:order_data) {create(:order_on_cart_invalid, user_id: user.id)}
      it "@orderが注文済みになっていないこと" do
        request
        order_data.reload
        expect(order_data.status).to eq(:on_cart)
      end

      it "エラーが返ってくる" do
        request
        expect(response).to render_template :show
      end
    end
  end
end