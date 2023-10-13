When("the user submits the query {string}") do |query|
    visit '/chatgpt' 
    fill_in 'Query', with: query
    click_button 'get content'
end
    
  Then("the user should not receive a response") do
    expect(page).not_to have_content('Response:')
  end
  
  When("the user visits the ChatgptController page") do
    visit '/chatgpt'
  end
  
  Then("the user should see the input form") do
    expect(page).to have_field('Query')
    expect(page).to have_button('get content')
  end
  