require 'openssl'

# デフォルトのca_file/ca_dirを環境ごとに切り替え
case RUBY_PLATFORM
when /darwin/
  # macOS + Homebrew
  if system("which brew > /dev/null 2>&1")
    ca_prefix = ENV['HOMEBREW_PREFIX'] || `brew --prefix`.strip
    ca_file   = File.join(ca_prefix, 'etc/openssl@3/cert.pem')
    ca_dir    = File.join(ca_prefix, 'etc/openssl@3/certs')
  else
    # 万一brew未導入ならmacOSの共通パス
    ca_file = '/etc/ssl/cert.pem'
    ca_dir  = '/etc/ssl/certs'
  end
else
  # Linux / Render / AWS EC2
  ca_file = '/etc/ssl/certs/ca-certificates.crt'
  ca_dir  = '/etc/ssl/certs'
end

# Rails全体で使用されるOpenSSL環境変数を設定
ENV['SSL_CERT_FILE'] ||= ca_file
ENV['SSL_CERT_DIR']  ||= ca_dir

# OpenSSLのデフォルト検証設定を上書き
OpenSSL::SSL::SSLContext::DEFAULT_PARAMS[:ca_file] = ca_file
OpenSSL::SSL::SSLContext::DEFAULT_PARAMS[:ca_path] = ca_dir
OpenSSL::SSL::SSLContext::DEFAULT_PARAMS[:verify_mode] = OpenSSL::SSL::VERIFY_PEER

# デバッグ用（デプロイ後にコメントアウト可）
Rails.logger.info("[SSL] ca_file: #{ca_file}, ca_dir: #{ca_dir}") if defined?(Rails)
