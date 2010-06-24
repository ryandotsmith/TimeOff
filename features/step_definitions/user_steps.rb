Given /^an user exists$/ do
 @account.users << @user = Factory(:user) if User.count.zero?
end

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

Given /^I sign in as someone else$/ do
  visit new_user_session_path
  fill_in('Email',    :with => @someone_else.email)
  fill_in('Password', :with => @someone_else.password)
  click_button("sign in")
end

Given /^There is a user with 4 vacation days remaining$/ do
  @user = Factory(:user, :max_vacation => 4)
end

When /^I follow "([^"]*)" within the user row$/ do |link|
  When %{I follow "#{link}" within "tr#user_#{@user.id}"}
end

Then /^I should see "([^"]*)" within the user row$/ do |content|
  Then %{I should see "#{content}" within "tr#user_#{@user.id}"}
end

