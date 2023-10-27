# spec/channels/channel_spec.rb
require 'rails_helper'

RSpec.describe ApplicationCable::Channel, type: :channel do
  it 'inherits from ActionCable::Channel::Base' do
    expect(described_class.ancestors).to include(ActionCable::Channel::Base)
  end
end