require "cgi"

unless CGI.class_variable_defined?(:@@accept_charset)
  CGI.class_variable_set(:@@accept_charset, nil)
end