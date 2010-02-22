require 'spec_helper'

describe Account do
  before(:each) do
    @valid_attributes = {
      :subdomain => "value for subdomain"
    }
  end

  it "should create a new instance given valid attributes" do
    Account.create!(@valid_attributes)
  end
end
