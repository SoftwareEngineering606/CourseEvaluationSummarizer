# frozen_string_literal: true

require 'webmock/cucumber'

When('the user submits the query {string}') do |query|
  visit '/chatgpt'

  # Stub the HTTP request and response
  stub_request(:post, 'https://api.openai.com/v1/chat/completions')
    .to_return(
      status: 200,
      body: { choices: [{ message: { content: 'Mocked response' } }] }.to_json,
      headers: { 'Content-Type' => 'application/json' }
    )

  fill_in 'Query', with: query
  click_button 'get content'
end

Then('the user should receive a response from ChatGPT') do
  expect(page).to have_content('Response:')
end

Then('the user should not receive a response') do
  expect(page).not_to have_content('Response:')
end

When('the user visits the ChatgptController page') do
  visit '/chatgpt'
end

Then('the user should see the input form') do
  expect(page).to have_field('Query')
  expect(page).to have_button('get content')
end
