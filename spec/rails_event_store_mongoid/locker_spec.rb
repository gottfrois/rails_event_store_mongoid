require 'spec_helper'

RSpec.describe RailsEventStoreMongoid::Locker do

  let(:locker) { described_class.new }
  let(:event) { RubyEventStore::Event.new }
  let(:event_repository) { RailsEventStoreMongoid::EventRepository.new }
  let(:aggregate_id) { SecureRandom.uuid }

  context 'when not using a lock' do

    before do
      2.times.map do
        Thread.new do
          event_repository.create(event, aggregate_id)
        end
      end.each(&:join)
    end

    it 'stores 2 times the event' do
      expect(event_repository.read_stream_events_forward(aggregate_id).count).to eq(2)
    end

  end

  context 'when using a lock' do

    def store
      2.times.map do
        Thread.new do
          locker.with_lock(aggregate_id) do
            event_repository.create(event, aggregate_id)
          end
        end
      end.each(&:join)
    end

    let(:locker) { described_class.new }

    it 'raises and stores 1 time the event' do
      expect { store }.to raise_error(RubyEventStore::CannotObtainLock)
      expect(event_repository.read_stream_events_forward(aggregate_id).count).to eq(1)
    end

  end

end
