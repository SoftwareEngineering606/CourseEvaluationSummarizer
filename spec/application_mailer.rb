# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ApplicationMailer', type: :mailer do
  it 'defaults are set correctly' do
    expect(ApplicationMailer.default[:from]).to eq('from@example.com')
    expect(ApplicationMailer._layout).to eq('mailer')
  end
end
