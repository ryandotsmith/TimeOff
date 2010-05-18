Given /^an account has been provisioned with email "([^\"]*)" and password "([^\"]*)"$/ do |email, password|
  @account.users << @user = Factory(:user, :email => email, :password_confirmation => password, :password => password) 
end

Given /^I am signed in$/ do
  @account.users << @user = Factory(:user)

  visit new_subdomain_user_session_path(@account,@account)
  fill_in('email',    :with => @user.email)
  fill_in('password', :with => @user.password)
  click_button("sign in")
end


