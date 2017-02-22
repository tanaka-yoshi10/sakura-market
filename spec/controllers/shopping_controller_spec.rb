require 'rails_helper'

describe ShoppingController do
  describe 'GET #index' do
    let!(:user) {
      user = create(:user_normal)
      session[:user_id] = user.id
    }
    let!(:ship_time) { ShipTime.create(shiptime_code: '00', display_name: '未指定')}
    let!(:p1) {create(:product_tomato)}
    let!(:p2) {create(:product_nasu)}

    context 'without params' do
      it "populates an array of all products" do
        get :index
        expect(assigns(:products)).to match_array([p1, p2])
      end

      it "renders the :index template" do
        get :index
        expect(response).to render_template :index
      end
    end
  end

  describe 'GET #show' do
    let!(:user) {
      user = create(:user_normal)
      session[:user_id] = user.id
    }
    let!(:ship_time) { ShipTime.create(shiptime_code: '00', display_name: '未指定')}
    let(:p1) {create(:product_tomato)}

    context 'with valid attributes' do
      it "assigns the requested contact to @product" do
        get :show, params: {id: p1.id}
        expect(assigns(:product)).to eq p1
      end

      it "renders the :show template" do
        get :show, params: {id: p1.id}
        expect(response).to render_template :show
      end
    end
  end

end