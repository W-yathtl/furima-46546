class ApplicationController < ActionController::Base
  before_action :basic_auth
# Devise用ストロングパラメータ
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  # 新規登録(sign_up)時に追加の項目を許可
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [
      :nickname,
      :last_name,
      :first_name,
      :last_name_kana,
      :first_name_kana,
      :birthday
    ])
  end

  private

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]  # 環境変数を読み込む記述に変更
    end
  end

   #  ログアウト後の遷移先をルートパスに設定
  def after_sign_out_path_for(resource_or_scope)
    root_path
  end

end