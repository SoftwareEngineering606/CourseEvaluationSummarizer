Given('there are recent Excel sheets in the database') do
  # Create some ExcelSheet records in the database
  @excel_sheets = []
  3.times do |i|
    @excel_sheets << ExcelSheet.create(name: "Sheet #{i}")
  end
end

When('the user visits the homepage') do
  visit '/'
end

Then("the user should see a list of recent Excel sheets") do
  expect(page).to have_css('.recents')
end

When('the user click the download Excel sheet page') do
  visit(download_report_path)
end

Then("the user should be able to download the Excel sheet")do
  expect(page).to have_link('Download Excel')
  click_link('Download Excel')
end