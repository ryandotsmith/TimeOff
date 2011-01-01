require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe DayoffMailer do

  include EmailSpec::Helpers
  include EmailSpec::Matchers
  include ActionController::UrlWriter

  describe "sending a message for new request" do

    before do
      @user    = Factory(:user)
      @dayoff  = Factory(:dayoff, :account => @user.account, :user => @user)

      @email = DayoffMailer.deliver_new_request_message_for_manager(@dayoff)
    end

    it "should use the dayoff id for the from address" do
      @email.should deliver_from("Time Off <#{@dayoff.id}@listen.timeoffhq.com>")
    end

  end
end
