# frozen_string_literal: true

# spec/controllers/pages_controller_spec.rb

require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  let(:file_path) { 'app/assets/images/SampleExcel.xlsx' }
  let(:excel_parser) { ExcelParser.new(file_path) }

  describe 'parse_data' do
    it 'parses data from the Excel file' do
      get :generate
      expect(response).to redirect_to(download_report_path)
    end
  end
  describe 'GET #validate' do
    it 'redirects to download report path' do
      get :validate
      expect(response).to redirect_to(download_report_path)
    end
  end
end
ggi
RSpec.describe PagesController, type: :controller do
  describe 'GET download' do
    context 'when the Excel file exists' do
      it 'sends the Excel file for download' do
        get :download
        expect(response).to be_successful
        expect(response.headers['Content-Type']).to eq('application/vnd.openxmlformats-officedocument.spreadsheetml.sheet')
        expect(response.headers['Content-Disposition']).to include('attachment; filename="grouped_data.xlsx"')
      end
    end

    context 'when the Excel file does not exist' do
      it 'sets a flash message and redirects to the root path' do
        allow(File).to receive(:exist?).and_return(false)
        get :download
        expect(flash[:alert]).to eq('The Excel file does not exist.')
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
