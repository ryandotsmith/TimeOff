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

    stub_subscription_create

    click_link "billing"
    click_button "0-4"
    fill_in "Name on Card", :with => "Ryan Smith"
    fill_in "Card Number", :with => "1"
    select "12",    :from => "Expiration Month"
    select "2012",  :from => "Expiration Year"
    fill_in "Security Code", :with => "123"
    click_button "submit"
    page.should have_css(".message", :text => "Account Subscription Successfully Updated!")
  end

  scenario "Adding an invalid credit card", :js => true do
    click_link "billing"
    click_button "0-4"
    fill_in "Name on Card", :with => "Ryan Smith"
    fill_in "Card Number", :with => "2"
    select "12",    :from => "Expiration Month"
    select "2012",  :from => "Expiration Year"
    fill_in "Security Code", :with => "123"
    click_button "submit"
    page.should have_css(".message", :text => "Credit Card is invalid.")
  end


end
