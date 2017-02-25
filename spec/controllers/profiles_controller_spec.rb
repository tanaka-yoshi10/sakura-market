require 'rails_helper'

describe ProfilesController do
  describe 'GET #show' do
    let!(:user) {
      user = create(:user_normal)
      session[:user_id] = user.id
      user
    }
    let(:request) {get :show, params: {user_id: user.id}}

    context '正常値 住所あり' do
      let!(:address) {create(:address, user_id: user.id)}
      it "@addressに適切な値が設定されていること" do
        request
        expect(assigns(:address)).to eq address
      end

      it ":showテンプレートが表示されること" do
        request
        expect(response).to render_template :show
      end
    end

    context '正常値 住所なし' do
      it "@addressが新規で作成されていること" do
        request
        expect(assigns(:address)).to be_a_new(Address)
      end

      it "renders the :show template" do
        request
        expect(response).to render_template :show
      end
    end
  end

  describe 'GET #edit' do
    let!(:user) {
      user = create(:user_normal)
      session[:user_id] = user.id
      user
    }

    let(:request) {get :edit, params: {user_id: user.id}}

    context '正常値・住所あり' do
      it "@current_userに適切な値が設定されていること" do
        request
        expect(assigns(:current_user)).to eq user
      end

      it "renders the :edit template" do
        request
        expect(response).to render_template :edit
      end
    end

    context '正常値 住所なし' do
      it "@current_userに適切な値が設定されていること" do
        request
        expect(assigns(:current_user)).to eq user
      end

      it "renders the :show template" do
        request
        expect(response).to render_template :edit
      end
    end
  end

  describe 'GET #edit_address 一般' do
    let!(:user) {
      user = create(:user_normal)
      session[:user_id] = user.id
      user
    }
    let!(:address) {create(:address, user_id: user.id)}
    let(:request) {get :edit_address, params: {user_id: user.id}}

    context 'with valid attributes' do
      it "assigns the requested contact to @address" do
        request
        expect(assigns(:address)).to eq address
      end

      it "renders the :edit template" do
        request
        expect(response).to render_template :edit_address
      end
    end
  end

  describe 'Patch #update' do
    let!(:user) {
      user = create(:user_normal)
      session[:user_id] = user.id
      user
    }
    let(:request) { patch :update, params: params }

    context '正常値' do
      let(:params) { {id: user.id, user: attributes_for(:user_normal, name: 'test9')} }
      it "@userに適切な値が設定されていること" do
        request
        user.reload
        expect(user.name).to eq 'test9'
      end

      it "redirects to #show" do
        request
        expect(response).to redirect_to profiles_path
      end
    end
    context '異常値' do
      let(:params) { {id: user.id, user: attributes_for(:user_normal, name: '')} }
      it "必須エラーになること" do
        request
        user.reload
        expect(user.name).not_to eq ''
      end

      it "redirects to #show" do
        request
        expect(response).to render_template :edit
      end
    end
  end

  describe 'Patch #update_address' do
    let!(:user) {
      user = create(:user_normal)
      session[:user_id] = user.id
      user
    }
    let!(:address) {create(:address, user_id: user.id)}
    let(:request) { patch :update_address, params: params }

    context '正常値' do
      let(:params) { {id: address.id, user_id: user.id, address: attributes_for(:address, zip_code: '9990001')} }
      it "@addressに適切な値が設定されていること" do
        request
        address.reload
        expect(address.zip_code).to eq '9990001'
      end

      it "redirects to #show" do
        request
        expect(response).to redirect_to profiles_path
      end
    end
    context '異常値' do
      let(:params) { {id: address.id, user_id: user.id, address: attributes_for(:address, zip_code: '')} }
      it "@必須エラーになること" do
        request
        address.reload
        expect(address.zip_code).not_to eq ''
      end

      it "編集画面に戻る" do
        request
        expect(response).to render_template :edit_address
      end
    end
  end
end