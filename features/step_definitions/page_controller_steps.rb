Given("there are recent Excel sheets in the database") do
    # Create some ExcelSheet records in the database
    @excel_sheets = []
    3.times do |i|
      @excel_sheets << ExcelSheet.create(name: "Sheet #{i}", file_url: "https://example.com/sheet#{i}.xlsx")
    end
  end
  
  When("I visit the homepage") do
    visit homepage_path
  end
  
  Then("I should see a list of recent Excel sheets") do
    # Write code to verify that the recent Excel sheets are displayed on the homepage.
    @excel_sheets.each do |excel_sheet|
      expect(page).to have_content(excel_sheet.name)
    end
  end
  
  Given("there is an Excel sheet available for download") do
    # Create a sample ExcelSheet record in the database
    @sample_excel_sheet = ExcelSheet.create(name: "Sample Sheet", file_url: "https://example.com/sample.xlsx")
  end
  
  When("I click the download Excel sheet page") do
    visit download_excel_sheet_path
  end
  
  Then("I should be able to download the Excel sheet") do
    # Write code to verify that the download link or behavior is working as expected.
    expect(page.response_headers['Content-Type']).to eq('application/vnd.openxmlformats-officedocument.spreadsheetml.sheet')
  end
  