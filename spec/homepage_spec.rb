require 'rails_helper'

RSpec.feature 'Homepage' do
  scenario 'displays the correct HTML structure and styles' do
    visit '/'

    # Test the header
    expect(page).to have_selector('header')
    expect(page).to have_css('header h1', text: 'Course Evaluation Summarizer')

    # Test the main content
    expect(page).to have_selector('.main-content')

    # Test the upload_files section
    expect(page).to have_selector('.upload_files')
    expect(page).to have_css('.upload_files h1', text: 'Upload Files')

    # Test the recents section
    expect(page).to have_selector('.recents')
    expect(page).to have_css('.recents h1', text: 'Recents')
  end
end
