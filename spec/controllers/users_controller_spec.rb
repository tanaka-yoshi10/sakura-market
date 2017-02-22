require 'rails_helper'

describe Admin::UsersController do
  describe 'GET #index' do
    let!(:u1) {create(:user_1)}
    let!(:u2) {create(:user_2)}
    let(:request) {get :index}
    context '全ユーザの一覧' do
      let!(:user) {
        admin = create(:user_admin)
        session[:user_id] = admin.id
        admin
      }
      it "populates an array of all products" do
        request
        expect(assigns(:users)).to match_array([user, u1, u2])
      end

      it "renders the :index template" do
        request
        expect(response).to render_template :index
      end
    end

    context '一般ユーザがアクセスすると、' do
      let!(:user) {
        admin = create(:user_normal)
        session[:user_id] = admin.id
        admin
      }
      it "#showにリダイレクトされる" do
        request
        expect(response).to redirect_to admin_admins_path
      end
    end
  end

  describe 'GET #show' do
    let!(:user) {
      admin = create(:user_admin)
      session[:user_id] = admin.id
    }
    let!(:u1) {create(:user_1)}
    let!(:u2) {create(:user_2)}
    let(:request) {get :show, params: {id: u1.id}}

    context 'with valid attributes' do
      it "assigns the requested contact to @product" do
        request
        expect(assigns(:user)).to eq u1
      end

      it "renders the :show template" do
        request
        expect(response).to render_template :show
      end
    end
  end

  describe 'GET #new' do
    let!(:user) {
      admin = create(:user_admin)
      session[:user_id] = admin.id
    }
    let!(:u1) {create(:user_1)}
    let!(:u2) {create(:user_2)}
    let(:request) {get :new}

    context 'with valid attributes' do
      it "assigns the requested contact to @product" do
        request
        expect(assigns(:user)).to be_a_new(User)
      end

      it "renders the :show template" do
        request
        expect(response).to render_template :new
      end
    end
  end

  describe 'GET #edit' do
    let!(:user) {
      admin = create(:user_admin)
      session[:user_id] = admin.id
    }
    let!(:u1) {create(:user_1)}
    let!(:u2) {create(:user_2)}
    let(:request) {get :edit, params: {id: u1.id}}

    context 'with valid attributes' do
      it "assigns the requested contact to @user" do
        request
        expect(assigns(:user)).to eq u1
      end

      it "renders the :edit template" do
        request
        expect(response).to render_template :edit
      end
    end
  end

  describe 'POST #create' do
    let!(:user) {
      admin = create(:user_admin)
      session[:user_id] = admin.id
    }
    let(:request) { post :create, params: params }

    context '正常値' do
      let(:params) { {user: attributes_for(:user_1)} }
      it "ssigns the requested contact to @user" do
        expect{
          request
        }.to change(User, :count).by(1)
      end

      it "redirects to #show" do
        request
        expect(response).to redirect_to admin_user_path(assigns[:user])
      end
    end

    context '異常値（名前が未指定）' do
      let(:params) { {user: attributes_for(:user_1, name: '')} }
      it "@userが追加されていないこと" do
        expect{
          request
        }.to change(User, :count).by(0)
      end

      it "#newテンプレートが表示されること" do
        request
        expect(response).to render_template :new
      end
    end
  end

  describe 'Patch #update' do
    let!(:user) {
      admin = create(:user_admin)
      session[:user_id] = admin.id
    }
    let!(:u1) {create(:user_1)}
    let(:request) { patch :update, params: params }

    context '正常値' do
      let(:params) { {id: u1.id, user: attributes_for(:user_1, name: 'test9')} }
      it "@userが正しく変更されていること" do
        request
        u1.reload
        expect(u1.name).to eq 'test9'
      end

      it "#showテンプレートが表示される" do
        request
        expect(response).to redirect_to admin_user_path(assigns[:user])
      end
    end
    context '異常値（名前未指定）' do
      let(:params) { {id: u1.id, user: attributes_for(:user_1, name: '')} }
      it "@userが変更されていないこと" do
        request
        u1.reload
        expect(u1.name).to eq build(:user_1).name
      end

      it "#editテンプレートが表示される" do
        request
        expect(response).to render_template :edit
      end
    end
  end

  describe 'Delete #destroy' do
    let!(:user) {
      admin = create(:user_admin)
      session[:user_id] = admin.id
    }
    let!(:u1) {create(:user_1)}
    let(:request) { delete :destroy, params: params }

    context 'with valid attributes' do
      let(:params) { {id: u1.id} }
      it "assigns the requested contact to @user" do
        expect{
          request
        }.to change(User, :count).by(-1)
      end

      it "redirects to #show" do
        request
        expect(response).to redirect_to admin_users_path
      end
    end
  end
end