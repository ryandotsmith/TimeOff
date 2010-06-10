Given /^an account exists with a company name of "([^\"]*)"$/ do |company_name|
  @account = Factory(:account,:company_name => company_name)
end

Given /^I am signed in as the account owner$/ do
  @user = @account.owner
  visit new_user_session_path
  fill_in('user_session_email',    :with => @user.email)
  fill_in('user_session_password', :with => 'password' )
  click_button("sign in")
end

Given /^I am signed in as an employee of "([^\"]*)"$/ do |arg1|
  @user = Factory(:user) 
  @account.users << @user
  @account.save

  visit new_user_session_path
  fill_in('user_session_email',    :with => @user.email)
  fill_in('user_session_password', :with => 'password' )
  click_button("sign in")
end

Given /^I belong to the "([^\"]*)" account$/ do |arg1|
  user = @users.last
  @account.users << user
  @account.save
end

When /^I navigate to the "([^\"]*)" account signing page$/ do |company_name|
  visit new_user_session_url
end

When /^I should see message "([^\"]*)"$/ do |alt|
  page.should have_no_content(alt)
end
