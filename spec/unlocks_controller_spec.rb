# spec/controllers/users/unlocks_controller_spec.rb
require 'rails_helper'

RSpec.describe Users::UnlocksController, type: :controller do
  it 'inherits from Devise::UnlocksController' do
    expect(described_class.ancestors).to include(Devise::UnlocksController)
  end

  # You can write more test cases for the controller actions if needed
  # For example, testing the `new`, `create`, and `show` actions.
end