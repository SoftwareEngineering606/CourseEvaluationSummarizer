# spec/controllers/pages_controller_spec.rb

require 'rails_helper'



RSpec.feature 'Display list of Excel files' do
  scenario 'User visits the Excel files page' do
    visit '/'
    within('table') do
      expect(page).to have_selector('tr')
      expect(page).to have_content('Download Link')
      expect(page).to have_content('Name')
      expect(page).to have_content('Description')
      end
    end
  end

RSpec.feature 'Recents section is visible' do
    scenario 'Recents section is visible' do
      visit '/'
      expect(page).to have_selector('h1', text: 'Recents')
    end
  end
