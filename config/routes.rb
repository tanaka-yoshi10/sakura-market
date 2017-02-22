Rails.application.routes.draw do

  # 一般トップ
  root :to => 'shopping#index'

  # 商品一覧
  resources :shopping, only: [:index, :show]

  # カート
  resource :cart, only: [:show, :update]

  # プロフィール(自身の住所変更含む)
  resource :profiles, only: [:show, :edit, :update] do
    member do
      get 'edit_password'
      get 'edit_address'
      get 'edit_address_from_cart'
      patch 'update_address'
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
