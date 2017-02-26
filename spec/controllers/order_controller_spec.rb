require 'rails_helper'

describe OrdersController do

  let!(:cod_charge_01) { create(:cod_charge_01) }
  let!(:cod_charge_02) { create(:cod_charge_02) }
  let!(:cod_charge_03) { create(:cod_charge_03) }
  let!(:cod_charge_04) { create(:cod_charge_04) }

  describe 'GET #index' do
    let!(:user) {
      user = create(:user_normal)
      session[:user_id] = user.id
      user
    }
    let!(:ship_time) {
      create(:ship_time_00)
      create(:ship_time_03)
    }
    let!(:p1) {create(:product_tomato)}
    let!(:p2) {create(:product_nasu)}
    let!(:o1) {
      o1 = create(:order_on_cart_2item, user_id: user.id)
      o1.status = :ordered
      o1.save
      o1
    }
    let!(:o2) {
      o2 = create(:order_on_cart_2item, user_id: user.id)
      o2.status = :ordered
      o2.save
      o2
    }

    let(:request) { get :index }

    context 'パラメータなしの場合、' do
      it "すべての注文履歴が取得できること" do
        request
        expect(assigns(:orders)).to contain_exactly(o1, o2)
      end

      it ":indexテンプレートが使われること" do
        request
        expect(response).to render_template :index
      end
    end
  end

  describe 'Patch #update' do
    let!(:user) {
      user = create(:user_normal)
      session[:user_id] = user.id
      user
    }
    let!(:ship_time_00) {
      create(:ship_time_00)
    }
    let!(:ship_time_03) {
      create(:ship_time_03)
    }
    let!(:p1) {create(:product_tomato)}
    let!(:p2) {create(:product_nasu)}
    let!(:o1) {
      o1 = create(:order_on_cart_2item, user_id: user.id)
      o1.status = :ordered
      o1.save
      o1
    }
    let!(:o2) {
      o2 = create(:order_on_cart_2item, user_id: user.id)
      o2.status = :ordered
      o2.save
      o2
    }

    #let(:request) { patch :update, params: params }
    let(:request) { patch :update, format: :js, params: params }

    context '正常値' do
      let(:today) {
        now = Time.zone.now
        today = Date.new(now.utc.year, now.utc.month, now.utc.day)
      }
      let(:params) {
        {id: o1.id, order: {ship_time_id: ship_time_03.id, ship_date: today} }
      }
      it "@orderに正しい値が設定されていること" do
        request
        o1.reload
        expect(o1.ship_time_id).to eq ship_time_03.id
        expect(o1.ship_date).to eq today
      end

      it '戻り値jsの場合,javascriptが戻されること' do
        request
        expect(response.headers['Content-Type']).to match 'text/javascript; charset=utf-8'
      end
    end

    context '異常値' do
      let(:today) {
        now = Time.zone.now
        today = Date.new(now.utc.year, now.utc.month, now.utc.day)
      }
      let(:params) {
        {id: o1.id, order: {ship_time_id: -1, ship_date: today } }
      }
      it "@orderが変更されていないこと" do
        request
        o1.reload
        expect(o1.status).to eq(:ordered)
      end

      it '戻り値jsの場合,javascriptが戻されること' do
        request
        expect(response.status).to eq(500)
      end
    end
  end

end