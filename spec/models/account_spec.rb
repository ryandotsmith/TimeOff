require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Account do
  describe "validations" do
    it "should not allow duplicate subdomains" do
      Factory(:account)
      Factory.build(:account).should_not be_valid
    end
  end
end
