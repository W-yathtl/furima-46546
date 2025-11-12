require "cgi"

CGI.class_eval do
  class_variable_set(:@@accept_charset, nil) unless class_variable_defined?(:@@accept_charset)
end
CGI.unescape("init")