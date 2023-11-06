require 'rails_helper'

RSpec.describe Users::OmniauthCallbacksController, type: :controller do
  let(:auth) {  request.env['omniauth.auth'] }
  let(:user) { create_user } # Use let to create a user

  def create_user(attrs = {})
    User.create!(
      email: attrs[:email] || 'user@example.com',
      password: attrs[:password] || 'password',
    # Add other attributes as needed
      )
  end

  describe '#google_oauth2', render_views: false do
    context 'when user is present' do
      it 'signs out all scopes, sets success flash message, and signs in the user' do
        expect(User).to receive(:from_omniauth).with(auth).and_return(user)
        expect(controller).to receive(:sign_out_all_scopes)
        expect(controller).to receive(:sign_in_and_redirect).with(user, event: :authentication)
        @request.env["devise.mapping"] = Devise.mappings[:user]
        get :google_oauth2
        expect(response).to be_successful
      end
    end

    # context 'when user is not present' do
    #   it 'sets an alert flash message and redirects to the sign-in page' do
    #     user = nil
    #
    #     @request.env["devise.mapping"] = Devise.mappings[:user]
    #     get :google_oauth2
    #
    #     expect(response).to redirect_to(new_user_session_path)
    #     expect(User).to receive(:from_omniauth).with(auth).and_return(user)
    #     expect(controller).not_to receive(:sign_out_all_scopes)
    #     expect(controller).to receive(:redirect_to).with(new_user_session_path)
    #   end
    # end
    

  end
end
