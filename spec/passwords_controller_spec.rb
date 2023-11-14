require 'rails_helper'

RSpec.describe Users::PasswordsController, type: :controller do
  let(:controller) { Users::PasswordsController.new }

  it 'exists' do
    expect(controller).to be_a(Users::PasswordsController)
  end
end