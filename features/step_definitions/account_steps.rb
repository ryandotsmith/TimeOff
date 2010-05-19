Given /^an account exists with a subdomain of "([^\"]*)"$/ do |subdomain|
  @account = Factory(:account,:subdomain => subdomain)
  host! "#{@account.subdomain}.local"
end

Given /^I am signed in as the account owner$/ do
  @user = Factory(:user)
  @account.owner_id = @user.id
  @account.save

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

When /^I navigate to the "([^\"]*)" account signing page$/ do |subdomain|
  account = Account.find_by_subdomain(subdomain)
  visit new_subdomain_user_session_url(account)
end

