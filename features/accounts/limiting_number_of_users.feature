Feature: Limiting User Accounts
  In order to add more users to my account
  As a manager
  I want to upgrade my account

  Scenario: Adding 6th user to a 0-5 user plan
    Given an account exists with a company name of "wonderset"
    And I am signed in as the account owner
    And I have a subscription with plan: "0-5-users"
    And I have 5 users in my account
    When I follow "employees"
    And I follow "new employee"
    Then I should see "You can only have 5 users on your plan. Please upgrade to add more users."

  Scenario: Adding 6th user to an upgraded plan
    Given an account exists with a company name of "wonderset"
    And I am signed in as the account owner
    And I have a subscription with plan: "0-5-users"
    And I have 5 users in my account
    When I follow "employees"
    And I follow "new employee"
    Then I should see "You can only have 5 users on your plan. Please upgrade to add more users."
    When I upgrade my subscription with plan: "6-25-users"
    And I follow "new employee"
    Then I should be on the new user page
