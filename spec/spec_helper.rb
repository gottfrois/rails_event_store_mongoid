$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'rails_event_store_mongoid'
require 'pry'

Mongoid.load!('./spec/config/mongoid.yml', 'test')

RSpec.configure do |config|
  config.before do
    Mongoid.purge!
  end
end
