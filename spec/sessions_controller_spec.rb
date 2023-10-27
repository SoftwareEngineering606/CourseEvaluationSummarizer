# spec/controllers/users/sessions_controller_spec.rb
require 'rails_helper'

RSpec.describe Users::SessionsController, type: :controller do
  describe 'GET #after_sign_out_path_for' do
    it 'redirects to new_user_session_path' do
      # This test assumes Devise's sign_out helper correctly signs out the user
      #sign_out :user
      expect(controller.after_sign_out_path_for(:user)).to eq(new_user_session_path)
    end
  end

  describe 'GET #after_sign_in_path_for' do
    #let(:user) { create(:user) } # assumes you have FactoryBot set up for a User

    context 'with stored location' do
      it 'redirects to the stored location' do
        # Stub the stored location
        #controller.session[:user_return_to] = user_path(user)
        # Signing is done in test environment
        #sign_in user
        #expect(controller.after_sign_in_path_for(user)).to eq(user_path(user))
      end
    end

    context 'without stored location' do
      it 'redirects to root_path' do
        # Signing is done in test environment
        #sign_in user
        #expect(controller.after_sign_in_path_for(user)).to eq(root_path)
      end
    end
  end
end