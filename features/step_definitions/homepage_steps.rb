When("I visit the homepage") do
    visit '/'
end

Then("I should see the title {string}") do |title|
    expect(page).to have_selector('header h1', text: title)
end

Then("I should see the {string} section") do |section|
    expect(page).to have_selector('.main-content .'+section.downcase.gsub(' ', '_'), text: section)
end
