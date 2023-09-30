# spec/controllers/pages_controller_spec.rb

require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  describe 'GET #homepage' do
    it 'assigns @recent_excel_sheets' do
      # Create some example ExcelSheet records in the database
      excel_sheets = create_list(:excel_sheet, 3)

      get :homepage

      expect(assigns(:recent_excel_sheets)).to eq(excel_sheets)
    end

    it 'renders the homepage template' do
      get :homepage

      expect(response).to render_template('homepage')
    end
  end
end
