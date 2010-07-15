require File.dirname(__FILE__) + '/acceptance_helper'

feature "Creating a subscription", %q{

  In order to get continued service
  As a customer on the account edit page
  I want to create a subscription

} do

  background do
    account = Factory(:account, :company_name => "Wonder Set")
    owner   = account.owner
    sign_in_as(owner)
  end

  scenario "Adding a valid credit card", :js => true do
    click_link "billing"
    click_button "0-4"
    fill_in "Name on Card", :with => "Ryan Smith"
    fill_in "Card Number", :with => "1"
    fill_in "Expiration Date", :with => "12/2020"
    fill_in "Security Code", :with => "123"
    click_button "submit"
    page.should have_css(".message", :text => "Account Subscription Successfully Updated")
  end

end
