# frozen_string_literal: true

Given('I am on the main page') do
  visit root_path
end

When('I click on the button {string}') do |button_text|
  click_on button_text
end

Then('I should be on {string} page') do |_page_name|
  expect(current_path).to eq(download_report_path)
end

Then('I should be able to download the Excel') do
  headers = page.response_headers
  content_disposition = headers['Content-Disposition']
  expect(content_disposition).to include('attachment')
end
