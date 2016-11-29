require 'rails_event_store_mongoid/lock'

module RailsEventStoreMongoid
  class Locker

    def initialize(adapter: ::RailsEventStoreMongoid::Lock.new)
      @adapter = adapter
    end

    def with_lock(stream, &block)
      @adapter.with_lock(stream, &block)
    rescue ::Mongo::Error::OperationFailure => exception
      raise ::RailsEventStore::CannotObtainLock
    end

  end
end
