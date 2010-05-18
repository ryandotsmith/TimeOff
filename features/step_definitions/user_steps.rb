Given /^an account has been provisioned with email "([^\"]*)" and password "([^\"]*)"$/ do |email, password|
  @account.users << @user = Factory(:user, :email => email, :password_confirmation => password, :password => password) 
end
