require 'rails_helper'

describe Admin::ProductsController do
  describe 'GET #index' do
    let!(:user) {
      admin = create(:user_admin)
      session[:user_id] = admin.id
    }
    let(:p1) {create(:product_tomato)}
    let(:p2) {create(:product_nasu)}

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
      admin = create(:user_admin)
      session[:user_id] = admin.id
    }
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

  describe 'GET #new' do
    let!(:user) {
      admin = create(:user_admin)
      session[:user_id] = admin.id
    }
    let(:p1) {create(:product_tomato)}
    let(:request) { get :new }

    context 'with valid attributes' do
      it "assigns the requested contact to @product" do
        request
        expect(assigns(:product)).to be_a_new(Product)
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
    let(:p1) {create(:product_tomato)}
    let(:request) { get :edit, params: params }

    context 'with valid attributes' do
      let(:params) { {id: p1.id} }
      it "assigns the requested contact to @product" do
        request
        expect(assigns(:product)).to eq p1
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
      let(:params) { {product: attributes_for(:product_tomato)} }
      it "リクエストされた内容が@productに設定されること" do
        expect{
          request
        }.to change(Product, :count).by(1)
      end

      it "redirects to product#show" do
        # REVIEW noticeメッセージがURLに付加され、エラーとなってしまう
        pending("noticeメッセージがURLに付加され、エラーとなってしまう")
        request
        expect(response).to redirect_to admin_product_path(assigns[:product])
        # [review] noticeの内容まで指定してしまうので良いかと思います。
        # expect(response).to redirect_to admin_product_path(assigns[:product], notice: '商品の登録が完了しました')
      end
    end
    context '異常値' do
      let(:params) { {product: attributes_for(:product_tomato, name: '')} }
      it "@productが増えていないこと" do
        expect{
          request
        }.to change(Product, :count).by(0)
      end

      it "#newテンプレートが表示される" do
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
    let(:p1) {create(:product_tomato)}
    let(:request) { patch :update, params: params }

    context '正常値' do
      let(:params) { {id: p1.id, product: attributes_for(:product_tomato, name: 'トマト（修正版）')} }
      it "@productにリクエスト内容が反映されていること" do
        request
        p1.reload
        expect(p1.name).to eq 'トマト（修正版）'
      end

      it "#showテンプレートにリダイレクトされること" do
        # REVIEW noticeメッセージがURLに付加され、エラーとなってしまう
        pending("noticeメッセージがURLに付加され、エラーとなってしまう")
        request
        expect(response).to redirect_to admin_product_path(assigns[:product])
        # [review] noticeの内容まで指定してしまうので良いかと思います。
        # expect(response).to redirect_to admin_product_url(assigns[:product], notice: '商品の更新が完了しました')
      end
    end
    context '異常値' do
      let(:params) { {id: p1.id, product: attributes_for(:product_tomato, name: '')} }
      it "@productが変わっていないこと" do
        request
        p1.reload
        expect(p1.name).to eq build(:product_tomato).name
      end

      it "#editテンプレートにリダイレクトされること" do
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
    let!(:p1) {create(:product_tomato)}
    let(:request) { delete :destroy, params: params }

    context '正常値' do
      let(:params) { {id: p1.id} }
      it "@productが削除されること" do
        expect{
          request
        }.to change(Product, :count).by(-1)
      end

      it "product#showにリダイレクトされること" do
        request
        expect(response).to redirect_to admin_products_path
      end
    end

    context '異常値' do
      let(:params) { {id: "-1"} }
      it "@productが削除されないこと" do
        expect{
          request
        }.to change(Product, :count).by(0)
      end

      it "RecordNotFoundになること" do
        request
        expect(response.status).to eq(404)
      end
    end
  end
end