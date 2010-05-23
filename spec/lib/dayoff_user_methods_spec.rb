require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe DayoffUserMethods do
  describe "returns statistical data" do
    it "should return pending requests" do
      user   = Factory(:user)
      dayoff = Factory(:dayoff,:user => user)
      user.daysoff << dayoff
      user.save

      user.pending_requests.should eql([dayoff])
    end
  end
end
