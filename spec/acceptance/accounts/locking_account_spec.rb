require File.dirname(__FILE__) + '/../acceptance_helper'

feature "Locking an account due to subscriptions status", %q{

  In order to make money
  As the primary shareholder of Time Off
  I want the system to lock users after their trial has expired

} do

  background do
  end

  scenario "Redirect account owner to billing", :js => true do
    account = Factory(:account)
    Account.stub!(:find).and_return(account)
    account.stub!(:expired_subscription?).and_return(true)

    sign_in_as(account.owner)
    page.should have_content('Your trial has expired.')
    page.should have_css('#update-credit-card')
  end

  scenario "Redirect user to notice page", :js => true do
    account = Factory(:account)
    Account.stub!(:find).and_return(account)
    account.stub!(:expired_subscription?).and_return(true)
    regular_user = Factory(:user, :account => account)
    sign_in_as(regular_user)
    page.should have_content('Your trial has expired.')
    page.should have_content("Please ask #{account.owner.name} to activate account.")
  end

end
