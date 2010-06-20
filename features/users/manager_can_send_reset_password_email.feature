Feature: Manager can send a reset password email to user
  In order to help my users get signed in
  As a manager on the edit user popup
  I want to send an email with a reset password link

  Background:
    Given an account exists with a company name of "wonderset"
    And I am signed in as the account owner

    Scenario: Sending the email
      Given an user exists 
      And I am on the settings page
      When I follow "edit" withing the user row
      And I press "reset password"
      Then the user should receive an email
      When they open the email
      Then they should see "Password Reset Instructions" in the email body
