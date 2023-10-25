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