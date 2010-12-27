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
  end

  describe "callbacks" do
  end

  describe "managers" do
    it "should return a list of managers" do
      account = Factory(:account)
      manager = Factory(:manager,:account => account)
      Factory(:user, :account => account)

      account.users.count.should eql(2)
      account.managers.count.should eql(1)
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

  describe "i_cal" do
    it "should generatea random token for the account" do
      @account = Factory(:account)
      @account.generate_i_cal_token!
      one_token = @account.i_cal_token
      @account.generate_i_cal_token!
      another_token = @account.i_cal_token
      one_token.should_not eql(another_token)
    end
  end


end
