$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'rails_event_store_mongoid'

Mongoid.load!("spec/mongoid.yml", :test)

RSpec.configure do |config|
  config.before :example do
    Mongoid.purge!
  end
end
