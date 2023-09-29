class PagesController < ApplicationController
  def homepage
  end
  def new
    redirect_to root_path
  end
  def validate
    redirect_to download_report_path
  end
end
