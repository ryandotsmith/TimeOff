Feature: Manager should deny time off request
  In order to manage my team's effectiveness
  As a manager on the requests popup 
  I want to deny the request

  Background:
    Given an account exists with a company name of "wonderset"
    And I am signed in as the account owner
    And Someone else has pending time off

  @wip
  Scenario: Deny request in the popup
    Given I am on the account page
    When I follow "respond"
    And I press "deny"
    Then I should see "Request denied. An email has been sent to the employee."

  Scenario: Send email to employee

  Scenario: Reflect denial in employee's account page

