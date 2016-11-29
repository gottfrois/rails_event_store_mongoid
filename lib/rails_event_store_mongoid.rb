require 'rails_event_store/all'
require 'rails_event_store_mongoid/locker'
require 'rails_event_store_mongoid/event'
require 'rails_event_store_mongoid/event_repository'
require 'rails_event_store_mongoid/version'

RailsEventStore.event_repository = RailsEventStoreMongoid::EventRepository.new
