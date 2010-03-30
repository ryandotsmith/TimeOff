Feature: Making the account creator the owner

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



