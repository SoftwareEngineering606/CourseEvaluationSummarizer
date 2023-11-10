require 'rails_helper'

RSpec.describe Users::ConfirmationsController, type: :controller do
  let(:controller) { Users::ConfirmationsController.new }

  it 'exists' do
    expect(controller).to be_a(Users::ConfirmationsController)
  end
end