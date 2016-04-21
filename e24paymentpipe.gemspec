# -*- encoding: utf-8 -*-
$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)

require "e24paymentpipe/version"

Gem::Specification.new do |s|
  s.name        = "e24paymentpipe"
  s.version     = E24PaymentPipe::Version::STRING
  s.platform    = Gem::Platform::RUBY
  s.license     = "MIT"
  s.authors     = ["Flatstack"]
  s.homepage    = "https://github.com/fs/e24paymentpipe"
  s.summary     = ""

  s.files            = `git ls-files -- lib/*`.split("\n")
  s.files           += %w[README.md]
  s.require_path     = "lib"

  s.required_ruby_version = ">= 2.1.0"

  s.add_dependency "rubyzip", ">= 0.9.4"
  s.add_dependency "httparty", ">= 0.6.1"
  s.add_dependency "zip-zip"

  s.add_development_dependency "rake", ">= 11.1.2"
  s.add_development_dependency "rspec", ">= 2.14"
end
