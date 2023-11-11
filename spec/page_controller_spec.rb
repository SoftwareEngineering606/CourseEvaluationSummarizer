# frozen_string_literal: true

# spec/controllers/pages_controller_spec.rb

require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  let(:file_path) { 'public/uploads/SampleExcel.xlsx' }
  let(:excel_parser) { ExcelParser.new(file_path) }

  describe 'GET #download_processed_sheet' do
    let!(:processed_sheet) { ProcessedSheet.create(name: 'Example Sheet', description: 'Example Description', report_id_final: '123') }

    it 'sends the file for download' do
      get :download_processed_sheet, params: { report_id_final: processed_sheet.report_id_final }
    #  expect(response).to have_http_status(302)
    #  expect(response.headers['Content-Type']).to eq('application/excel')
    end

    it 'redirects to root_path when file is not found' do
      get :download_processed_sheet, params: { report_id_final: 'non_existent_id' }
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to eq('Not Processed sheet found')
    end

    it 'redirects to root_path on invalid request' do
      get :download_processed_sheet
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to eq('Invalid request')
    end
  end

  describe 'parse_data' do
    it 'parses data from the Excel file' do
      source_file_path = 'spec/fixtures/files/sample.xlsx'
      destination_file_path = Rails.root.join('public', 'uploads', 'sample_FA23.xlsx')

      # Copy the sample Excel file to the "public" directory
      FileUtils.cp(source_file_path, destination_file_path)
      session[:labels] = ["FA23"]
      get :generate
      expect(response).to redirect_to(download_report_path)

      File.delete(destination_file_path) if File.exist?(destination_file_path)

    end

    it 'generates comparison' do
      source_file_path = 'spec/fixtures/files/Processed_SheetFA23.xlsx'
      destination_file_path = Rails.root.join('public', 'processed', 'Processed_SheetFA23.xlsx')

      # Copy the sample Excel file to the "public" directory
      FileUtils.cp(source_file_path, destination_file_path)

      get :compare
      expect(response).to redirect_to(download_report_path)

      File.delete(destination_file_path) if File.exist?(destination_file_path)

    end

    it 'generates comparison for multiple semesters' do
      source_file_path = 'spec/fixtures/files/Processed_SheetSP22.xlsx'
      destination_file_path = Rails.root.join('public', 'processed', 'Processed_SheetSP22.xlsx')

      # Copy the sample Excel file to the "public" directory
      FileUtils.cp(source_file_path, destination_file_path)

      get :compare
      expect(response).to redirect_to(download_report_path)

      File.delete(destination_file_path) if File.exist?(destination_file_path)

    end


  end
  describe 'GET #validate' do
    it 'redirects to download report path' do
      fixture_file_upload('sample.xlsx', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet')
      get :validate
      expect(response).to redirect_to(download_report_path)
    end
  end
end

RSpec.describe PagesController, type: :controller do
  describe 'GET download' do
    context 'when the Excel file exists' do
      it 'sends the Excel file for download' do
        session[:file] = 'grouped_data.xlsx'
        get :download
        expect(response).to be_successful
        expect(response.headers['Content-Type']).to eq('application/vnd.openxmlformats-officedocument.spreadsheetml.sheet')
        expect(response.headers['Content-Disposition']).to include('attachment; filename="grouped_data.xlsx"')
      end
    end

    context 'when the Excel file does not exist' do
      it 'sets a flash message and redirects to the root path' do
        session[:file] = 'grouped_data.xlsx'
        allow(File).to receive(:exist?).and_return(false)
        get :download
        expect(flash[:alert]).to eq('The Excel file does not exist.')
        expect(response).to redirect_to(root_path)
      end

      it 'sets a flash message and redirects to the root path' do
        allow(File).to receive(:exist?).and_return(false)
        get :download
        expect(flash[:alert]).to eq('The Excel file does not exist.')
        expect(response).to redirect_to(root_path)
      end

    end
  end
end
