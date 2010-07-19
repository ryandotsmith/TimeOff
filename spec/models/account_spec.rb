require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Account do

  describe "associations" do
    context "with daysoff" do
      it "should scope queries to daysoff which belong to an account" do
        user   = Factory(:user)
        account = Factory(:account)
        dayoff  = account.daysoff.create(Factory.attributes_for(:dayoff,:user => user))
        account.daysoff.should eql([dayoff])
      end
    end
    context "with users" do
      it "should accept a user id for owner relation" do
        account = Factory(:account)
        owner   = Factory(:manager, :account => account)
        account.owner = owner
        account.owner.should eql(owner)
      end
    end
  end

  describe "callbacks" do
  end

  describe "managers" do
    it "should return a list of managers" do
      account = Factory(:account)
      account.owner = Factory(:manager, :account => account)
      manager = Factory(:manager, :account => account)
      account.users << manager << Factory(:user, :account => account)

      account.users.count.should eql(3)
      account.managers.count.should eql(2)
      account.managers.should include manager
    end
    context "ownership" do
      before(:each){ @account = Factory(:account) }
      it "should be added to the creator" do
        user = Factory(:user)
        User.should_receive(:find).and_return(user)
        @account.owner.should eql(user) 
      end
    end
  end

  describe "subscriptions" do
    before(:each){@account = Factory(:account)}
    it "should create a subscription if one can not be found by account id"
    describe "credit cards" do
      it "should return the masked credit card if the account has a subscription"
    end
  end


end
