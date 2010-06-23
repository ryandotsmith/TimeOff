Feature: Manager can add notes to request
  In order to keep a detailed record of requests
  As a manager on the request approval popup
  I want to be able to add a note regarding my action

  Background:
    Given an account exists with a company name of "wonderset"
    And I am signed in as the account owner

    Scenario: Seeing the note in the email
      Given Someone else has pending time off 
      When I go to the account page
      And I follow "respond"
      And I fill in "Notes:" with "This is a note about the approval"
      And I press "approve"
      Then the employee should receive an email
      When they open the email
      Then they should see "This is a note about the approval" in the email body
