require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do

  describe "before destruction" do
    it "should stop if the user is an owner of an account" do
      owner   = Factory(:user)
      account = Factory(:account)
      account.owner_id = owner.id
      account.save

      owner.account_owner?.should be_true
      owner.destroy.should == false
    end
  end

  describe "getting" do
    before(:each) {@u = Factory(:user)}
    context "string attributes" do
      it "should return account owner status in to_s" do
        @u.should_receive(:manager?).and_return(true)
        @u.to_s.should eql('Ryan Smith (manager)')
      end
    end
  end

  describe "interacting with accounts" do
    it "should be able to deterimine if a user owns an account" do
      @account = Factory(:account)
      @user    = Factory(:user)

      @account.owner_id = @user.id
      @account.save

      @user.account_owner?.should be_true
    end
  end

  describe "managers" do
    before(:each) do
      @account = Factory(:account)
      @user    = Factory(:user, :account => @account)
      @manager = Factory(:manager, :account => @account)
      @account.owner = @manager
    end

    it "should report when asked if they manager a given user" do
      @manager.manages(@user).should be_true
    end

    it "should report false if asked when the user is not a manager" do
      @user.manages(@manager).should be_false
    end
  end

end
