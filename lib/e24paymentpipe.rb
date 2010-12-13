require "rubygems"
require "bundler/setup"

$LOAD_PATH.unshift(File.dirname(__FILE__) + '/e24paymentpipe')
require "errors"
require 'payment'
require 'secure_settings'
