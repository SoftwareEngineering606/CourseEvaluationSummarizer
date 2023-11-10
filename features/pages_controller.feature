Feature: Generate and download excel file

  As aan authorised user
  So that I can find the details of my feedback
  I want to generate and download the processed excel file

  Scenario: Able to generate and download excel
    Given I am on the main page
    And  I click on the button "Generate"
    Then  I should be on "download_report" page
    And I click on the button "Download Excel"
    And I should be able to download the Excel

  Scenario: User downloads a processed sheet
    Given there is a processed sheet with ID "123"
    When the user requests to download the processed sheet with ID "123"
    Then the file should be downloaded

  Scenario: User tries to download a non-existent processed sheet
    When the user requests to download a non-existent processed sheet with ID "999"
    Then the user should see a message indicating the file was not found
    And the user should be redirected to the homepage

  Scenario: User makes an invalid request to download a processed sheet
    When the user makes an invalid request to download a processed sheet
    Then the user should see a message indicating an invalid request
    And the user should be redirected to the homepage