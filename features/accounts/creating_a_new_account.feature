Feature: Creating a new account
  As a new customer
  I want to create an account
  So that I can start using Holiday

  Scenario: Creating a new account and then updating company info
    Given I am on the home page
    When I follow "Sign Up"
    Then I should see "Pricing"
    When I fill in "Company Name" with "wonderset"
    And I fill in "First Name" with "Ryan"
    And I fill in "Last Name" with "Smith"
    And I fill in "Email" with "ryan@wonderset.com"
    And I fill in "Password" with "password"
    And I fill in "Password Confirmation" with "password"
    And I press "submit"
    Then I should see "Employees"
