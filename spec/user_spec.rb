require 'rails_helper'

RSpec.describe User, type: :model do
  describe '.from_omniauth' do
    let(:auth) do
      OmniAuth::AuthHash.new(
        provider: 'google_oauth2',
        uid: '123456',
        info: {
          email: 'testuser@example.com',
          name: 'Test User',
          image: 'http://example.com/test_user.jpg'
        }
      )
    end

    context 'when a user with the given provider and uid exists' do
      it 'returns the existing user' do
        existing_user = User.create(
          provider: 'google_oauth2',
          uid: '123456',
          email: 'testuser@example.com',
          password: 'password',
          full_name: 'Test User',
          avatar_url: 'http://example.com/test_user.jpg'
        )

        user = User.from_omniauth(auth)

        expect(user).to eq(existing_user)
      end
    end

    context "when a user with the given provider and uid doesn't exist" do
      it 'creates a new user with the provided attributes' do
        user = User.from_omniauth(auth)

        expect(user.provider).to eq('google_oauth2')
        expect(user.uid).to eq('123456')
        expect(user.email).to eq('testuser@example.com')
        expect(user.full_name).to eq('Test User')
        expect(user.avatar_url).to eq('http://example.com/test_user.jpg')
        expect(user.persisted?).to be true
      end
    end
  end
end