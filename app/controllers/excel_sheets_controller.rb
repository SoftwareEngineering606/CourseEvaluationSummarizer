# frozen_string_literal: true

class ExcelSheetsController < ApplicationController
  #   # Displays a list of all excel sheets
  #   def index
  #     @excel_sheets = ExcelSheet.all
  #   end
  #
  #   # Show specific excel sheet
  #   def show
  #     @excel_sheet = ExcelSheet.find(params[:id])
  #   end
  #
class ExcelSheetsController < ApplicationController
  # Displays a list of all excel sheets
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
      uploaded_file: params[:uploaded_file],
      user_id: 123,
      report_id: 345,
      report_name: 'Dummy report',
      report_path: '/dummy/path',
      isProcessed: 'No'
    }
    @excel_sheet = ExcelSheet.new(specific_params)

    if @excel_sheet.save
      redirect_to generate_excel_path
    @excel_sheet = ExcelSheet.new(excel_sheet_params)

    if @excel_sheet.save
      redirect_to @excel_sheet
    else
      render 'new'
    end
  end
  #
  #   # Edit existing excel sheet
  #   def edit
  #     @excel_sheet = ExcelSheet.find(params[:id])
  #   end
  #
  #   # Update the excel sheet in the database
  #   def update
  #     @excel_sheet = ExcelSheet.find(params[:id])
  #
  #     if @excel_sheet.update(excel_sheet_params)
  #       redirect_to @excel_sheet
  #     else
  #       render 'edit'
  #     end
  #   end
  #
  #   # Delete the excel sheet from the database
  #   def destroy
  #     @excel_sheet = ExcelSheet.find(params[:id])
  #     @excel_sheet.destroy
  #
  #     redirect_to excel_sheets_path
  #   end
  #

  # Edit existing excel sheet
  def edit
    @excel_sheet = ExcelSheet.find(params[:id])
  end

  # Update the excel sheet in the database
  def update
    @excel_sheet = ExcelSheet.find(params[:id])

    if @excel_sheet.update(excel_sheet_params)
      redirect_to @excel_sheet
    else
      render 'edit'
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
    params.require(:excel_sheet).permit(:user_id, :report_id, :report_name, :report_path, :uploaded_file, :isProcessed)
    params.require(:excel_sheet).permit(:user_id, :report_id, :report_name, :report_path)
  end
end
