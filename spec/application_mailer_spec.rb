# spec/mailers/application_mailer_spec.rb
require 'rails_helper'

RSpec.describe ApplicationMailer, type: :mailer do
  it 'has the default "from" email set' do
    expect(ApplicationMailer.default[:from]).to eq('from@example.com')
  end
end