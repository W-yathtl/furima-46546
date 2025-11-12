ENV["BUNDLE_GEMFILE"] ||= File.expand_path("../Gemfile", __dir__)

require "bundler/setup" # Set up gems listed in the Gemfile.
require "bootsnap/setup" # Speed up boot time by caching expensive operations.
require 'cgi'
begin
  CGI.accept_charset = 'UTF-8'
rescue NameError
  CGI.send(:class_variable_set, :@@accept_charset, 'UTF-8')
end