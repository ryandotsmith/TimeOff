require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Creating a user" do
  controller_name :users
  it "should build an account on creation" do
    @user = User.new
    User.should_receive(:new).and_return(@user)
    @user.should_receive(:create_account)
    post :create
  end
end

