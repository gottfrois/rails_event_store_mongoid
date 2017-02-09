require 'mongoid'

module RailsEventStoreMongoid
  class Event
    include ::Mongoid::Document
    include ::Mongoid::Timestamps::Created::Short

    store_in collection: 'event_store_events'

    field :stream, type: String
    field :event_id, type: String
    field :event_type, type: String
    field :meta, type: Hash, default: {}
    field :data, type: Hash, default: {}

    field :ts, type: BSON::Timestamp, default: -> { BSON::Timestamp.new(0, 0) }

    index(event_id: 1)
    index(stream: 1, ts: 1)
  end
end
