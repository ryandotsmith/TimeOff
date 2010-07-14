require File.dirname(__FILE__) + '/acceptance_helper'

feature "Feature name", %q{

  In order to get continued service
  As a customer on the account edit page
  I want to add my credit card

} do

  background do
    account = Factory(:account, :company_name => "Wonder Set")
    owner   = account.owner
    sign_in_as(owner)
  end

  scenario "Adding a valid credit card" do
    click_link "settings"
    click_link "credit card"
    fill_in "Name on card", :with => "Ryan Smith"
    fill_in "Card Number", :with => "1"
    fill_in "Expiration Date", :with => "12/2020"
    fill_in "Security Code", :with => "123"
    click_button "submit"
    page.should have_css(".notice", :text => "Credit Card was successfully added")
  end

end
