require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Email do
  describe "getting the dayoff id from the to field" do
    context "from" do
      it "should return email address" do
        email = Email.new(:from=>"Time Off <224@listen.timeoffhq.com>\n")
        email.filtered_email_address.should eql("224@listen.timeoffhq.com")
      end
    end
    context "to" do
      it "should return an id" do
        email = Email.new(:to =>"Time Off <224@listen.timeoffhq.com>\n")
        email.filtered_dayoff_id.should eql("224")
      end
    end
  end
  describe "determining the approval of the email" do
    context "approved" do
      it "should find approve" do
        email = Email.new(:body => "approve this!")
        email.approved?.should be_true
      end
      it "should find approved" do
        email = Email.new(:body => "This is approved")
        email.approved?.should be_true
      end
    end
    context "denied" do
      it "should find deny" do
        email = Email.new(:body => "deny")
        email.approved?.should be_false
        email.denied?.should be_true
      end
    end
  end
end
