require 'rails_helper'

RSpec.describe Users::RegistrationsController, type: :controller do
  let(:controller) { Users::RegistrationsController.new }

  it 'exists' do
    expect(controller).to be_a(Users::RegistrationsController)
  end
end