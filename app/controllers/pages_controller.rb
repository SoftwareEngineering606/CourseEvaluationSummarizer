class PagesController < ApplicationController
  def homepage
    @recent_excel_sheets = ExcelSheet.all
  end

  def download_excel_sheet
  end
end
