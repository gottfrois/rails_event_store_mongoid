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

    index(event_id: 1)
    index(stream: 1, _id: 1)
  end
end
