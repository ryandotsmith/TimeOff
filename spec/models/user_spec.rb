require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do
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
end
