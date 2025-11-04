# payjp使う時は必要

ca_file = '/usr/local/etc/openssl@3/cert.pem'

ENV['SSL_CERT_FILE'] ||= ca_file

require 'openssl'
OpenSSL::SSL::SSLContext::DEFAULT_PARAMS[:ca_file] = ca_file
OpenSSL::SSL::SSLContext::DEFAULT_PARAMS[:verify_mode] = OpenSSL::SSL::VERIFY_PEER