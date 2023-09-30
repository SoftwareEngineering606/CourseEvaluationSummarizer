Feature: Homepage
    As a user
    I want to visit the homepage
    So that I can use the features of the application

    Scenario: Visit the homepage
        When I visit the homepage
        Then I should see the title "Course Evaluation Summarizer"
        And I should see the "Upload Files" section
        And I should see the "Choose a file to upload" field
        And I should see the "Generate" button
        And I should see the "Recents" section
        And I click on the "Generate" button
        Then I should be on the "Download File" page
        And I should see the "Download" button


