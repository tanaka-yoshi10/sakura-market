require 'rails_helper'

describe Admin::AdminsController do
  describe 'GET #index' do
    let(:request) {get :show}

    context 'with valid attributes' do
      it "assigns the requested contact to @user" do
        request
        expect(assigns(:user)).to be_a_new(User)
      end

      it "renders the :show template" do
        request
        expect(response).to render_template :show
      end
    end
  end

  describe '管理者ログイン（POST #create）' do
    let!(:user) { create(:user_admin) }
    let!(:user_normal) { create(:user_normal) }
    let(:request) { post :create, params: params }

    context 'with valid attributes' do
      let(:params) { {user: attributes_for(:user_admin)} }
      it "assigns the requested contact to @user" do
        request
        expect(session[:user_id]).to eq user.id
      end

      it "redirects to #show" do
        request
        expect(response).to redirect_to admin_users_path
      end
    end

    context 'ログイン失敗した場合、' do
      let(:params) { {user: attributes_for(:user_admin, password: "aaa")} }
      it "セッションにユーザIDは設定されない" do
        request
        expect(session[:user_id]).to be_nil
      end

      it "ログイン画面が表示される" do
        request
        expect(response).to render_template :show
      end
    end

  end

  describe 'DELETE #delete' do
    let!(:user) { create(:user_admin) }
    let(:request) { delete :delete }

    context 'with valid attributes' do
      it "assigns the requested contact to @user" do
        request
        expect(session).not_to include user.id
      end

      it "redirects to #show" do
        request
        expect(response).to redirect_to admin_admins_path
      end
    end
  end
end