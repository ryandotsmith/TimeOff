Given /^an account exists with a subdomain of "([^\"]*)"$/ do |subdomain|
  @account = Factory(:account,:subdomain => subdomain)
  #host! "#{account.subdomain}.example.com"
end

Given /^I am signed in as the account owner$/ do
  @user = Factory(:user)
  @account.owner_id = @user.id

  visit new_subdomain_user_session_path(@account,@account)
  fill_in('email',    :with => @user.email)
  fill_in('password', :with => @user.password)
  click_button("sign in")
end

Given /^I belong to the "([^\"]*)" account$/ do |arg1|
  user = @users.last
  @account.users << user
  @account.save
end
