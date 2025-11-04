Rails.application.routes.draw do
  devise_for :users
 # ルートパスにアクセスしてもindexメソッドでトップページにアクセスするように設定
  root to: 'items#index'

    resources :items, except: [:destroy] do
    resources :orders, only: [:index, :create]
  end
end
