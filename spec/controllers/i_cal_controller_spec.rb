require 'spec_helper'

describe ICalController do
  describe "iCal" do
    it "should find daysoff for an account" do
      @account = Factory(:account)
      get :show, :id => @account.i_cal_token
      response.should be_success
    end
  end
end
