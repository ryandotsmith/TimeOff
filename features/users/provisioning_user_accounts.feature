Feature: Provisioning useres for accounts
  In order to get employees in the system
  As an account owner
  I want to add users to my account

  Scenario: Adding users from the account page
    Given an account exists with a company name of "wonderset"
    And I am signed in as the account owner
    When I go to the account edit page
    And I follow "add user"
    And I fill in "Email" with "this.ryansmith@gmail.com"
    And I fill in "First Name" with "Ryan"
    And I fill in "Last Name" with "Smith"
    And I press "add"
    Then I should see "The new user will receieve an activation email."
    And "this.ryansmith@gmail.com" should receive an email
    When I open the email
    Then I should see "activate account" in the email body
    When I follow "activate account" in the email
