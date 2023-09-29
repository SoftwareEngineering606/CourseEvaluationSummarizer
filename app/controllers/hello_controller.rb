class HelloController < ApplicationController
  def index
    @recent_excel_sheets = ExcelSheet.all
    render 'homepage/homepage'
  end

  private

  def fetch_recent_excel_sheets
    ExcelSheet.order(created_at: :desc).limit(3)
  end
end