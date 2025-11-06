Rails.application.routes.draw do
  devise_for :users
 # ルートパスにアクセスしてもindexメソッドでトップページにアクセスするように設定
  root to: 'items#index'

    resources :items do
    resources :orders, only: [:index, :create]
  end
end
