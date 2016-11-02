# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rails_event_store_mongoid/version'

Gem::Specification.new do |spec|
  spec.name          = "rails_event_store_mongoid"
  spec.version       = RailsEventStoreMongoid::VERSION
  spec.authors       = ['gottfrois', 'mpraglowski']
  spec.email         = ['tomek.rybka@gmail.com', 'm@praglowski.com']

  spec.summary       = %q{Mongoid events repository for Rails Event Store}
  spec.description   = %q{Implementation of events repository based on Mongoid for Rails Event Store'}
  spec.homepage      = 'https://github.com/arkency/rails_event_store_mongoid'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rspec"

  spec.add_dependency 'mongoid', '~> 5.1'
  spec.add_dependency 'ruby_event_store', '~> 0.13.0'
  spec.add_dependency 'rails_event_store', '~> 0.13.0'
  spec.add_dependency 'activesupport', '>= 3.0'
  spec.add_dependency 'activemodel', '>= 3.0'
end
