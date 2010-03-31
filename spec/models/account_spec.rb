require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Account do

  describe "validations" do
    it "should not allow duplicate subdomains" do
      Factory(:account)
      Factory.build(:account).should_not be_valid
    end
  end

  describe "callbacks" do
    context "after create" do
      it "should set owner" do
        account = Factory.build(:account)
        account.save
        account.owner_id.should eql(account.users.first.id)
      end
    end
  end

  describe "ownership" do
    before(:each){ @account = Factory(:account) }
    it "should be added to the creator" do
      user = Factory(:user)
      User.should_receive(:find).and_return(user)
      @account.owner.should eql(user) 
    end
  end
end
