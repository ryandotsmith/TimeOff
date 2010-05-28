Feature: Making the account creator the owner

  Scenario: Creating an account and registering the user as the owner of the account
    Given I am on the home page
    When I follow "Sign Up"
    And I fill in "Company Name" with "wonderset"
    And I fill in "Email" with "ryan@wonderset.com"
    And I fill in "Password" with "password"
    And I fill in "Password Confirmation" with "password"
    And I press "submit"
    Then I should see "Account Administration"
