Feature: ChatgptController
  As a user
  I want to interact with ChatGPT
  So that I can receive responses

  Scenario: User submits a query and receives a response
    When the user submits the query "Hello, ChatGPT!"
    Then the user should receive a response from ChatGPT

  Scenario: User visits the ChatgptController page
    When the user visits the ChatgptController page
    Then the user should see the input form
