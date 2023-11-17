# frozen_string_literal: true

class ExcelSheetsController < ApplicationController
  # Displays a list of all excel sheet s
  def index
    @excel_sheets = ExcelSheet.all
  end

  # Show specific excel sheet
  def show
    @excel_sheet = ExcelSheet.find(params[:id])
  end

  # Creates a new excel sheet
  def new
    @excel_sheet = ExcelSheet.new
  end

  # Handles saving a new excel sheet to the database
  def create
    specific_params = {
      uploaded_files: params[:uploaded_files],
      name: 'Dummy report',
      description: 'Dummy test report',
      user_id: 123,
      report_id: 345,
      report_name: 'Dummy report',
      report_path: '/dummy/path',
      isProcessed: 'No'
    }
    @excel_sheet = ExcelSheet.new(specific_params)
    Array(params[:uploaded_files]).each do |uploaded_file|
      @excel_sheet.uploaded_files.attach(uploaded_file)
    end

    uploaded_files = params[:uploaded_files]

    puts "Received params: #{params.inspect}"

    if uploaded_files.present?

      Array(params[:uploaded_files]).drop(1).each do |file|
        if  file.content_type != 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
          flash[:error] = 'Only excel files (.xlsx) are allowed!'
          redirect_to root_path
          return
        end
      end

      upload_directory = Rails.root.join('public', 'uploads')

    
      labels = []

      # Delete all existing Excel files in the directory
      existing_excel_files = Dir["#{upload_directory}/*.xlsx"]
      existing_excel_files.each { |file| File.delete(file) }

      Array(params[:uploaded_files]).drop(1).each do |file|
        if file.content_type == "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
         filename_without_extension = File.basename(file.original_filename, File.extname(file.original_filename))
         last_four_characters = filename_without_extension[-4..-1]
         labels.push(last_four_characters)
         file_path = Rails.root.join('public', 'uploads', filename_without_extension+".xlsx")


        # Save the file to the specified path.
        File.open(file_path, 'wb') do |f|
          f.write(file.read)
        end
        end
      end
      session[:labels]=labels.uniq
    end

    if @excel_sheet.save
      redirect_to generate_excel_path
    else
      render 'new'
    end
  end

  # Edit existing excel sheet
  def edit
    @excel_sheet = ExcelSheet.find(params[:id])
  end

  # Update the excel sheet in the database
  def update
    @excel_sheet = ExcelSheet.find(params[:id])
    if @excel_sheet.update(excel_sheet_params)
      redirect_to @excel_sheet, notice: 'Excel sheet was successfully updated.'
    else
      render :edit
    end
  end

  # Delete the excel sheet from the database
  def destroy
    @excel_sheet = ExcelSheet.find(params[:id])
    @excel_sheet.destroy

    redirect_to excel_sheets_path
  end

  private

  def excel_sheet_params
    params.require(:excel_sheet).permit(:user_id, :report_id, :report_name, :report_path, { uploaded_files: [] },
                                        :isProcessed)
  end
end
