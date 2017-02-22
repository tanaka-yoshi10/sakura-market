require 'rails_helper'

describe SessionsController do
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

  describe 'POST #create' do
    let!(:user) { create(:user_normal) }
    let(:request) { post :create, params: params }

    context 'ログイン成功' do
      let(:params) { {user: attributes_for(:user_normal)} }
      it "セッションにユーザIDが設定される" do
        request
        expect(session[:user_id]).to eq user.id
      end

      it "ルートパスにリダイレクトされる" do
        request
        expect(response).to redirect_to root_path
      end
    end
    context 'ログイン失敗した場合、' do
      let(:params) { {user: attributes_for(:user_normal, password: "aaa")} }
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
    let!(:user) { create(:user_normal) }
    let(:request) { delete :delete }

    context 'with valid attributes' do
      it "assigns the requested contact to @user" do
        request
        expect(session).not_to include user.id
      end

      it "redirects to #show" do
        request
        expect(response).to redirect_to session_path
      end
    end
  end
end