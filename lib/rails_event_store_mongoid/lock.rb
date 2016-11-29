require 'mongoid'

module RailsEventStoreMongoid
  class Lock
    include Mongoid::Document

    store_in collection: 'event_store_locks'

    field :_id, type: String, default: ->{ SecureRandom.uuid }, overwrite: true
    field :ts, type: Time

    def with_lock(stream)
      lock = self.class.create(_id: stream, ts: Time.now.utc)
      yield if block_given?
      lock.delete
    end

    index({ ts: 1 }, { expire_after_seconds: 30 })
  end
end
