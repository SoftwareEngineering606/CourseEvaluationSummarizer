# frozen_string_literal: true

When('I visit the UI homepage') do
  visit '/'
end

Then('I should see the title {string}') do |title|
  expect(page).to have_selector('header h1', text: title)
end

Then('I should see the {string} section') do |section|
  expect(page).to have_selector(".main-content .#{section.downcase.gsub(' ', '_')}", text: section)
end

Then('I should see the {string} field') do |_chooseFile|
  expect(page).to have_field('file')
end

Then('I should see the {string} button') do |btnLabel|
  expect(page).to have_button(btnLabel)
end

And('I click on the {string} button') do |_btnLabel|
  click_button('Generate')
end

And('I click on the {string} button in download Page') do |_btnLabel|
  click_link(_btnLabel)
end

Then('I should be on the {string} page') do |_pageName|
  expect(page).to have_current_path(download_report_path)
end
