require "cgi"
CGI.class_variable_set(:@@accept_charset, nil) unless CGI.class_variable_defined?(:@@accept_charset)