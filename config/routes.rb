Rails.application.routes.draw do
  # [review] 不要な空行やコメントは削除したいです
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
  # [review] ↑の部分、resourcesをうまく使いたいので、こう書くのはどうでしょうか(案)
  # resource :profiles, only: [:show, :update, :edit] do
  #   resource :password, only: [:edit, :update]
  #   resource :address, only: [:edit, :update]
  # end

  # 注文履歴
  resources :orders do  # [review] only等で使っていないactionは制限したいです。
    resources :order_items # [review] only等で使っていないactionは制限したいです。
  end

  # 一般ログイン
  resource :session, path: "login", only: [:create] do
    member do
      get  '/', to: "sessions#show" # [review] showではなくnewの方が自然な気がします。
      delete  '/', to: "sessions#delete"
    end
  end
  # [review] ↑はこう書けると良いのではと思います(案)
  # get '/login', to: 'sessions#new'
  # post '/login', to: 'sessions#create'
  # delete '/logout', to: 'sessions#delete'

  # サインアップ
  get '/sign_up', to: "registrations#new"
  post '/sign_up', to: "registrations#create"

  # 管理者
  namespace :admin do
    # ログイン
    resource :admins, path: "/", only: [:show, :create] do
      member do
        get  '/', to: "admins#show" # [review] showではなくnewの方が自然な気がします。
        delete  '/', to: "admins#delete"
      end
    end
    # [review] ↑もこんな感じにしたいところです。(案)
    # get '/login', to: 'sessions#new'
    # post '/login', to: 'sessions#create'
    # delete '/logout', to: 'sessions#delete'

    # ユーザ管理
    resources :users do
      resource :address, only: [:show, :edit, :update]
    end

    # 商品管理
    resources :products

  end

end
