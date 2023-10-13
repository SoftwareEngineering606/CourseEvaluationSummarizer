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
  end
end
