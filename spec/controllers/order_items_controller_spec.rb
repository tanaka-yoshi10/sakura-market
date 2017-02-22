require 'rails_helper'

describe OrderItemsController do

  describe 'POST #create' do
    let!(:user) {
      user = create(:user_normal)
      session[:user_id] = user.id
      user
    }
    let!(:ship_time) { create(:ship_time_00) }
    let(:product_tomato) {create(:product_tomato)}
    let!(:order_data) {create(:order_on_cart_2item, user_id: user.id)}
    let(:request_js) { post :create, format: :js, params: params }

    context 'with valid attributes' do
      let(:params) { {order_id: order_data.id, order_item: attributes_for(:order_item_1, quantity: 99, product_id: product_tomato.id)} }
      #let(:params) { {order_item: attributes_for(:order_item_1, product_id: product_tomato.id) } }
      it "assigns the requested contact to @order" do
        expect{request_js}.to change(OrderItem, :count).by(1)
      end

      it "renders the :show template" do
        request_js
        expect(response.headers['Content-Type']).to match 'text/javascript; charset=utf-8'
      end
    end
  end

  describe 'Patch #update' do
    let!(:user) {
      user = create(:user_normal)
      session[:user_id] = user.id
      user
    }
    let!(:ship_time) { create(:ship_time_00) }
    let!(:order_data) {create(:order_on_cart_2item, user_id: user.id)}
    let(:request_js) { patch :update, format: :js, params: params }

    context '正常系のテスト' do
      let(:params) { {order_id: order_data.id, id: order_data.order_items[0].id, order_item: attributes_for(:order_item_1, quantity: 99)} }
      it "order item の数量が変更されている" do
        request_js
        order_data.reload
        expect(order_data.order_items[0].quantity).to eq 99
      end

      it "戻り値がJSであること" do
        request_js
        expect(response.headers['Content-Type']).to match 'text/javascript; charset=utf-8'
      end
    end
  end

  describe 'Delete #destroy' do
    let!(:user) {
      user = create(:user_normal)
      session[:user_id] = user.id
      user
    }
    let!(:ship_time) { create(:ship_time_00) }
    let!(:order_data) {create(:order_on_cart_2item, user_id: user.id)}
    let(:request_js) { delete :destroy, format: :js, params: params }

    context '正常系のテスト' do
      let(:params) { {order_id: order_data.id, id: order_data.order_items[0].id} }
      it "order itemが1件削除されていること" do
        expect{request_js}.to change(OrderItem, :count).by(-1)
      end

      it "戻り値がJSであること" do
        request_js
        expect(response.headers['Content-Type']).to match 'text/javascript; charset=utf-8'
      end
    end
  end
end