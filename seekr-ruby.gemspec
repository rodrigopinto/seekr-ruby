# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'seekr/version'

Gem::Specification.new do |spec|
  spec.name          = "seekr-ruby"
  spec.version       = Seekr::VERSION
  spec.authors       = ["Rodrigo Pinto"]
  spec.email         = ["rodrigopqn@gmail.com"]
  spec.summary       = %q{Ruby client for Seekr Monitor API.}
  spec.description   = %q{Ruby client for Seekr Monitor API.}
  spec.homepage      = "http://github.com/rodrigopinto/seekr-ruby"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.files.reject! { |fn| fn.include? "spec" }

  spec.add_dependency "rest-client",          "1.7.2"
  spec.add_dependency "activesupport",        "~> 4.1"

  spec.add_development_dependency "bundler",  "~> 1.7"
  spec.add_development_dependency "rake",     "~> 10.0"
  spec.add_development_dependency "rspec",    "3.1.0"
  spec.add_development_dependency "webmock",  "1.20.3"
  spec.add_development_dependency "sinatra",  "1.4.5"
  spec.add_development_dependency "pry",      "0.10.3"
end
