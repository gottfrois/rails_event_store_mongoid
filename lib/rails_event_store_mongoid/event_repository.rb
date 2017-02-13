module RailsEventStoreMongoid
  class EventRepository

    def initialize(adapter: ::RailsEventStoreMongoid::Event)
      @adapter = adapter
    end
    attr_reader :adapter

    def create(event, stream_name)
      adapter.create(
        stream:     stream_name,
        event_id:   event.event_id,
        event_type: event.class,
        data:       event.data,
        meta:       event.metadata,
      )
      event
    end

    def delete_stream(stream_name)
      condition = {stream: stream_name}
      adapter.destroy_all condition
    end

    def has_event?(event_id)
      adapter.where(event_id: event_id).exists?
    end

    def last_stream_event(stream_name)
      build_event_entity(adapter.where(stream: stream_name).desc(:ts).first)
    end

    def read_events_forward(stream_name, start_event_id, count)
      stream = adapter.where(stream: stream_name)
      unless start_event_id.equal?(:head)
        starting_event = adapter.find_by(event_id: start_event_id)
        stream = stream.where(:ts.gt => starting_event.ts)
      end

      stream.asc(:ts).limit(count)
        .map(&method(:build_event_entity))
    end

    def read_events_backward(stream_name, start_event_id, count)
      stream = adapter.where(stream: stream_name)
      unless start_event_id.equal?(:head)
        starting_event = adapter.find_by(event_id: start_event_id)
        stream = stream.where(:ts.lt => starting_event.ts)
      end

      stream.desc(:ts).limit(count)
        .map(&method(:build_event_entity))
    end

    def read_stream_events_forward(stream_name)
      adapter.where(stream: stream_name).asc(:ts)
        .map(&method(:build_event_entity))
    end

    def read_stream_events_backward(stream_name)
      adapter.where(stream: stream_name).desc(:ts)
        .map(&method(:build_event_entity))
    end

    def read_all_streams_forward(start_event_id, count)
      stream = adapter
      unless start_event_id.equal?(:head)
        starting_event = adapter.find_by(event_id: start_event_id)
        stream = stream.where(:ts.gt => starting_event.ts)
      end

      stream.asc(:ts).limit(count)
        .map(&method(:build_event_entity))
    end

    def read_all_streams_backward(start_event_id, count)
      stream = adapter
      unless start_event_id.equal?(:head)
        starting_event = adapter.find_by(event_id: start_event_id)
        stream = stream.where(:ts.lt => starting_event.ts)
      end

      stream.desc(:ts).limit(count)
        .map(&method(:build_event_entity))
    end

    private

    def build_event_entity(record)
      return nil unless record
      record.event_type.constantize.new(
        event_id: record.event_id,
        metadata: record.meta,
        data: record.data,
      )
    end
  end
end
