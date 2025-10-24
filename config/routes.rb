Rails.application.routes.draw do
 # ルートパスにアクセスしてもindexメソッドでトップページにアクセスするように設定
  root to: 'items#index'

end
