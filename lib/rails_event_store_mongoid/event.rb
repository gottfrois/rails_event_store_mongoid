module RailsEventStoreMongoid
  class Event
    include ::Mongoid::Document
    include ::Mongoid::Timestamps::Created

    store_in collection: 'event_store_events'

    field :stream, type: String
    field :event_id, type: String
    field :event_type, type: String
    field :metadata, type: Hash, default: {}
    field :data, type: Hash, default: {}

    index(stream: 1)
  end
end
