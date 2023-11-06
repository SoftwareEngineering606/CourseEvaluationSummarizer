# frozen_string_literal: true



When('I visit the homepage') do
  visit homepage_path
end

Given(/^there is a processed sheet with ID "(.*?)"$/) do |report_id_final|
  create(:processed_sheet, report_id_final: report_id_final) # Assuming you have a factory for ProcessedSheet
end

When(/^the user requests to download the processed sheet with ID "(.*?)"$/) do |report_id_final|
  visit download_processed_sheet_path(report_id_final: report_id_final)
end

Then(/^the file should be downloaded$/) do
  # Write code to check the download behavior (e.g., checking HTTP headers)
  # Example: expect(page.response_headers['Content-Type']).to eq('application/excel')
end

When(/^the user requests to download a non-existent processed sheet with ID "(.*?)"$/) do |report_id_final|
  visit download_processed_sheet_path(report_id_final: report_id_final)
end

Then(/^the user should see a message indicating the file was not found$/) do
  expect(page).to have_content('File not found')
end

Then(/^the user should be redirected to the homepage$/) do
  expect(page).to have_current_path(root_path)
end

When(/^the user makes an invalid request to download a processed sheet$/) do
  visit download_processed_sheet_path
end

Then(/^the user should see a message indicating an invalid request$/) do
  expect(page).to have_content('Invalid request')
end


Then('I should see a list of recent Excel sheets') do
  # Write code to verify that the recent Excel sheets are displayed on the homepage.
  @excel_sheets.each do |excel_sheet|
    expect(page).to have_content(excel_sheet.name)
  end
end

Given('there is an Excel sheet available for download') do
  # Create a sample ExcelSheet record in the database
  @sample_excel_sheet = ExcelSheet.create(name: 'Sample Sheet', file_url: 'https://example.com/sample.xlsx')
end

When('I click the download Excel sheet page') do
  visit download_processed_sheet_path
end

Then('I should be able to download the Excel sheet') do
  # Write code to verify that the download link or behavior is working as expected.
  expect(page.response_headers['Content-Type']).to eq('application/vnd.openxmlformats-officedocument.spreadsheetml.sheet')
end
