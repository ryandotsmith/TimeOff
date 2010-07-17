module HelperMethods
  def sign_in_as(user)
    visit '/signin'
    fill_in "Email",    :with => user.email
    fill_in "Password", :with => 'password'
    click_button "sign in"
  end

  def stub_subscription_create
    account = Factory(:account)
    Account.stub!(:find).and_return(account)
    account.stub!(:create_subscription).and_return(true)
  end

end

Spec::Runner.configuration.include(HelperMethods)
