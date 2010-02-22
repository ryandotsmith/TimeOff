require 'spec_helper'

describe "Creating a user" do
  controller_name :users
  it "should build an account on creation" do
    @user = User.new
    User.should_receive(:new).and_return(@user)
    @user.should_receive(:build_account)
    post :create
  end
end

