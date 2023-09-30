class PagesController < ApplicationController
  def homepage
    @recent_excel_sheets = ExcelSheet.all
  end

  def download_excel_sheet
  end
  def validate
    redirect_to download_report_path
  end
end
