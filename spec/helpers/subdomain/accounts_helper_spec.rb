require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Subdomain::AccountsHelper do
  describe "building messages" do
    it "should register pending requests as messages" do
      account = Factory(:account) 
      user = Factory(:user) 
      pendign_request  = user.daysoff.create(Factory.attributes_for(:dayoff))
      user.should_receive(:pending_requests).and_return([pendign_request])
      helper.account_messages(account,user) do |message|
        message
      end.all? {|m| m.should be_instance_of NotificationMessage }
    end
  end
end
