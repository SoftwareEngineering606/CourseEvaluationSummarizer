# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ChatgptController, type: :controller do
  describe 'GET #index' do
    it 'does not assign @response when query is not present' do
      get :index

      expect(assigns(:response)).to be_nil
    end

    it 'renders the index template' do
      get :index

      expect(response).to render_template('index')
    end

    it 'assigns @response when query is present' do
      query = 'Hello, ChatGPT!'

      # Stub the ChatgptService call
      allow_any_instance_of(ChatgptService).to receive(:call).and_return('Response from ChatGPT')

      get :index, params: { query: }

      expect(assigns(:response)).to eq('Response from ChatGPT')
    end
  end
end
