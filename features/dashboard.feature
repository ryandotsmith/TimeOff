Feature: A dashboard for users
  As a timeoffhq user
  I want a dashboard
  So that I can get a quick view of my account

  Scenario: Displaying this year's time off
    Given an account exists with a subdomain of "wonderset"
    And I am signed in as an employee of "wonderset"
    And I have 1 unapproved vacation dayoff
    And I have 2 approved vacation daysoff
    When I go to the dashboard
    Then I should see message "vacation days remaining 8.0"
    And I should see message "etc days remaining 10.0"
    And I should see message "personal days remaining 10.0"
    And I should see message "request needs approval 1" 

