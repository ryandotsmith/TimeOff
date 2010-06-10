Given /^an account has been provisioned with email "([^\"]*)" and password "([^\"]*)"$/ do |email, password|
  @account.users << @user = Factory(:user, :email => email, :password_confirmation => password, :password => password) 
end

Given /^I am signed in$/ do
  @account.users << @user ||= Factory(:user)

  visit new_user_session_path
  fill_in('Email',    :with => @user.email)
  fill_in('Password', :with => @user.password)
  click_button("sign in")
end

Given /^There is a user with 4 vacation days remaining$/ do
  @user = Factory(:user, :max_vacation => 4)
end
