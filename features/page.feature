Feature: Pages Controller
    Background:
        Given there are recent Excel sheets in the database

    Scenario: User visits the homepage
        When the user visits the homepage
        Then the user should see a list of recent Excel sheets

    Scenario: User downloads an Excel sheet
        When the user click the download Excel sheet page
        Then the user should be able to download the Excel sheet
