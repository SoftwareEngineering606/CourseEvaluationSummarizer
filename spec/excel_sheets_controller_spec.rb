# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ExcelSheetsController, type: :controller do
  before(:each) do
    @valid_attributes = {
      user_id: 1, # replace with a valid user id
      report_id: 1, # replace with a valid report id
      report_name: 'Test Excel',
      report_path: '/path/to/excel'
    }

    @excel_sheet = ExcelSheet.create! @valid_attributes
  end

  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get :show, params: { id: @excel_sheet.to_param }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new ExcelSheet' do
        expect do
          post :create, params: { excel_sheet: @valid_attributes }
        end.to change(ExcelSheet, :count).by(1)
      end

      it 'redirects to the created excel sheet' do
        post :create, params: { excel_sheet: @valid_attributes }
      end
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      get :edit, params: { id: @excel_sheet.to_param }
      expect(response).to be_successful
    end
  end

  describe 'PATCH #update' do
    let(:new_attributes) do
      {
        report_name: 'Updated Report Name',
        report_path: '/new/path/to/excel'
      }
    end

    context 'with valid params' do
      it 'updates the requested excel sheet' do
        patch :update, params: { id: @excel_sheet.to_param, excel_sheet: new_attributes }
        @excel_sheet.reload
        expect(@excel_sheet.report_name).to eq('Updated Report Name')
        expect(@excel_sheet.report_path).to eq('/new/path/to/excel')
      end

      it 'redirects to the excel sheet' do
        patch :update, params: { id: @excel_sheet.to_param, excel_sheet: new_attributes }
        @excel_sheet.reload
        expect(response).to redirect_to(@excel_sheet)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested excel sheet' do
      expect do
        delete :destroy, params: { id: @excel_sheet.to_param }
      end.to change(ExcelSheet, :count).by(-1)
    end

    it 'redirects to the list of excel sheets' do
      delete :destroy, params: { id: @excel_sheet.to_param }
      expect(response).to redirect_to(excel_sheets_path)
    end
  end
end
