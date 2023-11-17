

require 'rails_helper'

RSpec.describe ExcelSheetsController, type: :controller do
  before(:each) do
    @valid_attributes = {
      user_id: 1,  # replace with a valid user id
      report_id: 1, # replace with a valid report id
      report_name: 'Test Excel',
      report_path: '/path/to/excel'
    }

    @excel_sheet = ExcelSheet.create! @valid_attributes
  end

  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      get :show, params: {id: @excel_sheet.to_param}
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new ExcelSheet" do
        expect {
          post :create, params: {excel_sheet: @valid_attributes}
        }.to change(ExcelSheet, :count).by(1)
      end

      it "redirects to the created excel sheet" do
        post :create, params: {excel_sheet: @valid_attributes}
        expect(response).to redirect_to(generate_excel_path)
      end
    end

    context 'when uploading invalid file types' do
      it 'sets flash[:error]' do
        invalid_file = fixture_file_upload('invalid_file.txt', 'text/plain')

        post :create, params: { uploaded_files: ["",invalid_file] }

        expect(flash[:error]).to eq('Only excel files (.xlsx) are allowed!')
      end
      end

  end

  describe 'POST #create' do
    it 'processes and saves uploaded files, ignoring the first file' do
      # Prepare a sample uploaded file
      sample_file = fixture_file_upload('sample.xlsx', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet')
      uploaded_files = ["",sample_file]

      post :create, params: { uploaded_files: uploaded_files }

      file_path = Rails.root.join('public', 'uploads')

      files_in_directory = Dir.entries(file_path).select { |file| File.file?(File.join(file_path, file)) }

      # Check if there is any file with '.xlsx' extension
      excel_file_present = files_in_directory.any? { |file| file.downcase.end_with?('.xlsx') }

      # Expect that at least one Excel file is present
      expect(excel_file_present).to be true

    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      get :edit, params: {id: @excel_sheet.to_param}
      expect(response).to be_successful
    end
  end

  describe "PATCH #update" do
    let(:new_attributes) {
      {
        report_name: 'Updated Report Name',
        report_path: '/new/path/to/excel'
      }
    }

    context "with valid params" do
      it "updates the requested excel sheet" do
        patch :update, params: {id: @excel_sheet.to_param, excel_sheet: new_attributes}
        @excel_sheet.reload
        expect(@excel_sheet.report_name).to eq('Updated Report Name')
        expect(@excel_sheet.report_path).to eq('/new/path/to/excel')
      end

      it "redirects to the excel sheet" do
        patch :update, params: {id: @excel_sheet.to_param, excel_sheet: new_attributes}
        @excel_sheet.reload
        expect(response).to redirect_to(@excel_sheet)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested excel sheet" do
      expect {
        delete :destroy, params: {id: @excel_sheet.to_param}
      }.to change(ExcelSheet, :count).by(-1)
    end

    it "redirects to the list of excel sheets" do
      delete :destroy, params: {id: @excel_sheet.to_param}
      expect(response).to redirect_to(excel_sheets_path)
    end
  end

  describe 'GET #new' do
    it 'assigns a new ExcelSheet to @excel_sheet' do
      get :new
      expect(assigns(:excel_sheet)).to be_a_new(ExcelSheet)
    end

    it 'renders the new template' do
      get :new
      expect(response).to render_template('new')
    end
  end
  end
