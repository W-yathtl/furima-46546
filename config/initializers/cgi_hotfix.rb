require "cgi"

CGI.class_eval do
  remove_class_variable(:@@accept_charset) if class_variable_defined?(:@@accept_charset)
  class_variable_set(:@@accept_charset, nil)
end