Feature: Manager can edit employee details
  In order to better organize my staff
  As a manager on the settings page
  I want to select and edit an employee

  Background:
    Given an account exists with a company name of "wonderset"
    And I am signed in as the account owner

    Scenario: Updating text fields on an employee
      Given an user exists 
      And I am on the settings page
      When I follow "edit" within the user row
      And I fill in "First Name" with "Not Another Like It"
      And I fill in "Last Name" with "Still None Like It"
      And I select "December 25, 2008" as the "user_date_of_hire" date
      When I press "submit"
      Then I should see "employee has been updated"
      And I should see "Not Another Like It" within the user row
