Feature: Creating a new account
  As a new customer
  I want to create an account
  So that I can start using Holiday

  Scenario: Creating a new account and then updating company info
    Given I am on the home page
    When I click sign up
    And I fill in email address with "ryan@wonderset.com"
    And I fill in password with "password"
    And I press "create"
    Then I should see "Update Your Company Profile"
