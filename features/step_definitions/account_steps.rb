Given /^an account exists with a subdomain of "([^\"]*)"$/ do |subdomain|
  @account = Factory(:account,:subdomain => subdomain)
  host! "#{@account.subdomain}.timeoff.local:3000"
end

Given /^I am signed in as the account owner$/ do
  @user = @account.owner
  visit new_subdomain_user_session_url(@account)
  fill_in('user_session_email',    :with => @user.email)
  fill_in('user_session_password', :with => 'password' )
  click_button("sign in")
end

Given /^I am signed in as an employee of "([^\"]*)"$/ do |arg1|
  @user = Factory(:user) 
  @account.users << @user
  @account.save

  visit new_subdomain_user_session_url(@account)
  fill_in('user_session_email',    :with => @user.email)
  fill_in('user_session_password', :with => 'password' )
  click_button("sign in")
end

Given /^I belong to the "([^\"]*)" account$/ do |arg1|
  user = @users.last
  @account.users << user
  @account.save
end

When /^I navigate to the "([^\"]*)" account signing page$/ do |subdomain|
  account = Account.find_by_subdomain(subdomain)
  visit new_subdomain_user_session_url(account)
end

