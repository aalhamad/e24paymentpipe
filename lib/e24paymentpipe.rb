require "rubygems"
require "bundler/setup"

$LOAD_PATH.unshift(File.dirname(__FILE__) + '/e24paymentpipe')
require "version"
require "errors"
require "config"
require "secure_settings"
require "parser"
require "url"
require "message"
require "payment"
require "transaction"

require "railtie" if defined?(Rails)
