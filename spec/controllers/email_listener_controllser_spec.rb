require 'spec_helper'

describe EmailListenerController do
  it "should render ok status" do
    email = Email.new
    Email.should_receive(:new).and_return(email)
    email.should_receive(:act!).and_return(true)
    post :listen
    response.should be_success
  end
end
