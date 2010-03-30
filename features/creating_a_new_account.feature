Feature: Creating a new account
  As a new customer
  I want to create an account
  So that I can start using Holiday

  Scenario: Creating a new account and then updating company info
    Given I am on the home page
    When I follow "Sign Up" 
    And I fill in "company name" with "wonderset"
    And I fill in "email address" with "ryan@wonderset.com"
    And I fill in "password" with "password"
    And I fill in "password confirmation" with "password"
    And I press "sign up"
    Then I should see "wonderset"
    And I should see "Update Your Company Profile"

  Scenario: Creating a new account with company name that is already in use
    Given an account exists with a subdomain of "wonderset"
    And I am on the home page
    When I follow "Sign Up"
    And I fill in "company name" with "wonderset"
    And I fill in "email address" with "ryan@wonderset.com"
    And I fill in "password" with "password"
    And I fill in "password confirmation" with "password"
    And I press "sign up"
    Then I should see "An account with name 'wonderset' already exists."

  Scenario: Creating an account and registering the user as the owner of the account
    And I am on the home page
    When I follow "Sign Up"
    And I fill in "company name" with "wonderset"
    And I fill in "email address" with "ryan@wonderset.com"
    And I fill in "password" with "password"
    And I fill in "password confirmation" with "password"
    And I press "sign up"
    Then I should see "Account Administration"
    And I should see "wonderset's hr department"



