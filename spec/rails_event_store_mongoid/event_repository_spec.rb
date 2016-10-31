require 'spec_helper'
require 'ruby_event_store'
require 'ruby_event_store/spec/event_repository_lint'

describe RailsEventStoreMongoid::EventRepository do

  # https://github.com/arkency/ruby_event_store/pull/31
  # it_behaves_like :event_repository, described_class

  specify 'initialize with adapter' do
    repository = described_class.new
    expect(repository.adapter).to eq(RailsEventStoreMongoid::Event)
  end

  specify 'provide own event implementation' do
    CustomEvent = Class.new
    repository = described_class.new(adapter: CustomEvent)
    expect(repository.adapter).to eq(CustomEvent)
  end

end
