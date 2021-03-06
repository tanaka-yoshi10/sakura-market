Rails.application.routes.draw do

  # 一般トップ
  root :to => 'shopping#index'

  # 商品一覧
  resources :shopping, only: [:index, :show]

  # カート
  resource :cart, only: [:show, :update]

  # プロフィール(自身の住所変更含む)
  resource :profiles, only: [:show] do
    member do
      get 'edit_password'
      get 'edit_address'
      get 'edit_profile'
      patch 'update_address'
      patch 'update_password'
      patch 'update_profile'
    end
  end

  # 注文履歴
  resources :orders do
    resources :order_items
  end

  # 一般ログイン
  resource :session, path: "login", only: [:create] do
    member do
      get  '/', to: "sessions#show"
      delete  '/', to: "sessions#delete"
    end
  end

  # サインアップ
  get '/sign_up', to: "registrations#new"
  post '/sign_up', to: "registrations#create"

  # 管理者
  namespace :admin do
    # ログイン
    resource :admins, path: "/", only: [:show, :create] do
      member do
        get  '/', to: "admins#show"
        delete  '/', to: "admins#delete"
      end
    end

    # ユーザ管理
    resources :users do
      resource :address, only: [:show, :edit, :update]
    end

    # 商品管理
    resources :products

  end

end
