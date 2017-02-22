require 'rails_helper'

describe Admin::AddressesController do
  describe 'GET #edit' do
    let!(:user) {
      admin = create(:user_admin)
      session[:user_id] = admin.id
    }
    let!(:u1) {create(:user_1)}
    let(:request) {get :edit, params: {user_id: u1.id}}

    context '正常値 住所あり' do
      let!(:a1) {create(:address, user_id: u1.id)}
      it "assigns the requested contact to @user" do
        request
        expect(assigns(:address)).to eq a1
      end

      it "renders the :edit template" do
        request
        expect(response).to render_template :edit
      end
    end

    context '正常値 住所なし' do
      it "assigns the requested contact to @user" do
        request
        expect(assigns(:address)).to be_a_new(Address)
      end

      it "renders the :edit template" do
        request
        expect(response).to render_template :edit
      end
    end
  end

  describe 'Patch #update' do
    let!(:user) {
      admin = create(:user_admin)
      session[:user_id] = admin.id
    }
    let!(:u1) {create(:user_1)}
    let!(:a1) {create(:address, user_id: u1.id)}
    let(:request) { patch :update, params: params }

    context '正常値' do
      let(:params) { {user_id: u1.id, id: a1.id, address: attributes_for(:address, zip_code: '1230001')} }
      it "assigns the requested contact to @product" do
        request
        a1.reload
        expect(a1.zip_code).to eq '1230001'
      end

      it "redirects to #show" do
        request
        expect(response).to redirect_to admin_users_path
      end
    end
    context '異常値' do
      let(:params) { {user_id: u1.id, id: a1.id, address: attributes_for(:address, zip_code: '')} }
      it "@必須エラーになること" do
        request
        a1.reload
        expect(a1.zip_code).not_to eq ''
      end

      it "編集画面に戻る" do
        request
        expect(response).to render_template :edit
      end
    end
  end

end