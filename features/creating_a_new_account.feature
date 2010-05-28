Feature: Creating a new account
  As a new customer
  I want to create an account
  So that I can start using Holiday

  Scenario: Creating a new account and then updating company info
    Given I am on the home page
    When I follow "Sign Up" 
    Then I should see "3 reasons why you'll love Time Off"
    When I fill in "Company Name" with "wonderset"
    And I fill in "Email" with "ryan@wonderset.com"
    And I fill in "Password" with "password"
    And I fill in "Password Confirmation" with "password"
    And I press "submit"
    Then I should see "Settings"
    And I should see "Account Administration"

  Scenario: Creating a new account with company name that is already in use
    Given an account exists with a subdomain of "wonderset"
    And I am on the home page
    When I follow "Sign Up"
    And I fill in "Company Name" with "wonderset"
    And I fill in "Email" with "ryan@wonderset.com"
    And I fill in "Password" with "password"
    And I fill in "Password Confirmation" with "password"
    And I press "submit"
    Then I should see "An account with name wonderset already exists."


