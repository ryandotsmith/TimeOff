require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Dayoff do
  describe "denying the dayoff" do
    before(:each) {@dayoff = Factory(:dayoff,:leave_length => 'whole', :begin_time => Time.now)}
    it "should create a delayed job" do
      @dayoff.deny(Factory(:user))

    end
  end
  describe "status" do
    before(:each) {@dayoff = Factory(:dayoff,:leave_length => 'whole', :begin_time => Time.now)}
    it "should return approved if the dayoff has been approved" do
      user = Factory(:user)
      @dayoff.approve(user)
      @dayoff.status.should eql('approved')
    end
    it "should return denied if the dayoff has been denied" do
      user = Factory(:user)
      @dayoff.deny(user)
      @dayoff.status.should eql('denied')
    end
    it "should return pending if the dayoff has been created but not approved or denied" do
      @dayoff.status.should eql('pending')
    end
  end
  describe "to string methods" do
    it "should return a hash of attributes required by the full calendar lib" do
      user = Factory(:user)
      date = Time.now
      dayoff = Factory(:dayoff,:leave_length => 'whole', :begin_time => date)
      hash = {:title=>"Ryan Smith", :start=>dayoff.begin_time.iso8601, :end=>dayoff.end_time.iso8601, :allDay=>true}
      dayoff.to_fullcalendar_format(user).should include hash
    end
  end
  describe "sending mail after create" do
    context "when dayoff is in pending state" do
    end
  end
end







describe "creating a dayoff" do
  before(:each) do
    @user     = Factory( :user )
    @dt       = MONDAY_THIS_YEAR
  end

  describe "scrubbing the input" do
    it "should sanitize the description" do
      dayoff = Factory.build( :dayoff, :description => "&& bad" )
      dayoff.description.should == "&& bad"
      dayoff.save
      dayoff.description.should == "&amp;&amp; bad"
    end
  end

  describe "creating half day" do
    it "should save when nothing is wrong" do
      dayoff = Factory.build(  :dayoff,
                             :leave_length => 'half',
                             :user => @user,
                             :begin_time => MONDAY_THIS_YEAR,
                             :end_time   => nil)
      dayoff.save.should eql( true )
    end
    it "should fail when half day falls into existing range of daysoff" do
      dayoff = Factory( :dayoff,
                       :leave_length => 'many',
                       :user         => @user,
                       :begin_time   => @dt,
                       :end_time     => @dt + 4.days)

      bad_dayoff = Factory.build( :dayoff,
                                 :leave_length => 'whole',
                                 :user         => @user,
                                 :begin_time   => @dt + 2.days,
                                 :end_time     => nil)
      @user.daysoff << dayoff
      @user.save

      bad_dayoff.should_not be_valid
      bad_dayoff.save.should eql( false )
    end
  end
  describe "validating the users date range" do
    before(:each) do
      @dayoff = Factory.build( :dayoff,
                              :begin_time => DateTime.now,
                              :end_time   => DateTime.now - 2.days )
    end
    it "should ensure that end date is later than earlier date" do
      @dayoff.should_not be_valid
      @dayoff.get_length.should eql( 0.0 )
    end
  end
  describe "two daysoff on one calendar day" do
    it "should not find a dayoff in range when user has only one dayoff" do
      user    = Factory(:user)
      dayoff = Factory.build(  :dayoff,
                             :user => user,
                             :begin_time =>  DateTime.now,
                             :end_time   =>  DateTime.now + 2.days)
      dayoff.in_range_of_existing.should eql( false )
    end#it

    it "should error when a user has one dayoff and then requests idenctical set of days for another dayoff" do
      user   = Factory(:user)
      dayoff = Factory( :dayoff,
                       :leave_length => 'many',
                       :user         => user,
                       :begin_time   => DateTime.now,
                       :end_time     => DateTime.now + 2.days)
      user.daysoff << dayoff
      user.save

      another_dayoff = Factory.build( :dayoff,
                                     :leave_length => 'many',
                                     :user         => user,
                                     :begin_time   =>  DateTime.now,
                                     :end_time     =>  DateTime.now + 2.days)
      user.daysoff << another_dayoff
      user.save

      another_dayoff.in_range_of_existing.should eql( true )
    end

    describe "new daysoff should be inspected and reported if they include a date in users history" do
      before(:each) { @user = Factory(:user) }
      it "should add an error when a new dayoff is spanning previous daysoff" do
        dayoff_one = Factory(:dayoff,
                             :leave_length => 'whole',
                             :user         => @user,
                             :begin_time   => MONDAY_THIS_YEAR,
                             :end_time     => MONDAY_THIS_YEAR + 3.days)

        @user.daysoff << dayoff_one
        @user.save

        dayoff_two = Factory.build(:dayoff,
                                   :leave_length => 'whole',
                                   :user         => @user,
                                   :begin_time   => MONDAY_THIS_YEAR,
                                   :end_time     => MONDAY_THIS_YEAR )
        @user.daysoff << dayoff_two
        dayoff_two.in_range_of_existing.should eql( true )
        dayoff_two.should_not be_valid
      end


    end

    context "" do
      date = MONDAY_THIS_YEAR
      before(:each) do
        @user    = Factory( :user )
        @dayoff1 = Factory( :dayoff, :user => @user,
                           :begin_time    => date,
                           :end_time      => date + 2.days)

        @user.daysoff << @dayoff1
        @user.save
        @dayoff2 = Factory.build(:dayoff, :user => @user,
                                 :begin_time => date ,
                                 :end_time   => date + 2.days)
        @user.daysoff << @dayoff2
        @user.save
        @dayoff2.should_not be_valid
      end
      it "should calculate only uniquie dayoff days" do
        @dayoff1.get_length.should eql( 3.0 )
      end
    end
  end


end
describe "Dayoff states" do
  it "should be set to pending after new" do
    Factory(:dayoff).pending?().should eql(true)
  end
  it "should be set to pending if state is 0" do
    Factory(:dayoff,:state => 0).pending?().should eql(true)
  end
  it "should be set to approved if state is 1" do
    Factory(:dayoff,:state => 1).approved?().should eql(true)
  end
  it "should be set to denied if state is -1" do
    Factory(:dayoff,:state => -1).denied?().should eql(true)
  end
end
describe "Dayoff types" do
  # For now, i will specify an array in the model that will hold strings of daysoff
  # types. This array will get returned whenever we dealing with a dayoff. It should
  # be noted that there should be a database column that corresponds to the dayoff name
  # **ie => if there is a dayoff named = whatever. then there should be a database column
  # named = whatever_max.

  it "should maintain an ordered array of leave types" do
    Dayoff.get_dayoff_types.should eql(["etc","personal","vacation"])
    Dayoff.get_dayoff_types.should_not eql(["etc","vacation","personal"])
  end

end

describe "get length of dayoff" do

  it "should return an float which represents the number of whole days" do
    dt = MONDAY_THIS_YEAR
    @dayoff = Factory(
                      :dayoff,
                      :begin_time => dt,
                      :end_time   => dt + 1.days )
                      @dayoff.get_length.should eql( 2.0 )
  end# end it

  it "should correctly calculate 1 day of leave " do
    bt  = MONDAY_THIS_YEAR
    @dayoff = Factory(
                      :dayoff,
                      :begin_time =>  bt,
                      :end_time   =>  bt  )
                      @dayoff.get_length.should eql( 1.0 )

  end
  it "should correctly calculate 2 days of leave " do
    bt  = MONDAY_THIS_YEAR
    @dayoff = Factory(
                      :dayoff,
                      :leave_length => 'many',
                      :begin_time =>  bt,
                      :end_time   =>  bt + 1.days )
                      @dayoff.get_length.should eql( 2.0 )
  end# it

end# end describe

describe "adjust for half or whole days" do
  # there is a check box in the new dayoff form that will designate
  # the hald day request. The create action of the daysoff controller
  # will call this method if a hald day is requested.
  # likewise for whole days.

  # we can expect that the view form will give us a nil
  # value for the end time since the user will not even
  # be presented with a date selector for the end_time.

  before(:each) do
  end

  it "should add 5 hours to the begin date time" do
    @dayoff = Factory(       :dayoff,
                      :leave_length => 'half',
                      :begin_time => DateTime.now,
                      :end_time   => nil )
    # have to override the before_save method to make a half day save
    @dayoff.get_length.should eql( 0.5 )

  end

  it "should add 24 hours to the current DateTime submitted" do
    @dayoff = Factory(
                      :dayoff,
                      :leave_length => 'whole',
                      :begin_time => DateTime.now,
                      :end_time   => nil )
                      @dayoff.get_length.should eql( 1.0 )

  end
end #end describe

describe "should return specific data sets" do
  describe "get dayoffs statistics for all users" do
    before(:each) do
      date = MONDAY_THIS_YEAR
      @user_one       = Factory(:user)
      @user_two       = Factory(:user)

      # 3 days
      @dayoff_one    = Factory( :dayoff,
                               :leave_length  => 'many',
                               :state => 1,
                               :leave_type => 'etc',
                               :user => @user_one,
                               :begin_time => date,
                               :end_time   => date + 2.days)
      @user_one.daysoff << @dayoff_one
      @user_one.save
      # 3 days
      @dayoff_two    = Factory( :dayoff,
                               :leave_length  => 'many',
                               :state => 1,
                               :leave_type => 'etc',
                               :user => @user_one,
                               :begin_time => date + 7.days,
                               :end_time   => date + 9.days)
      @user_one.daysoff << @dayoff_two
      @user_one.save
      # 3 days
      @dayoff_three  = Factory( :dayoff,
                               :leave_length  => 'many',
                               :state => 1,
                               :leave_type => 'etc',
                               :user => @user_two,
                               :begin_time => date + 14.days,
                               :end_time   => date + 16.days )

      @user_two.daysoff << @dayoff_three
      @user_two.save
      @dayoff_four   = Factory( :dayoff,
                               :leave_length  => 'many',
                               :state => 0,
                               :leave_type => 'etc',
                               :user => @user_two,
                               :begin_time => date + 32.days,
                               :end_time   => date + 34.days )
      @user_two.daysoff << @dayoff_four
      @user_two.save
    end

    it "should calulate daysoff taken by single user" do
      sum = 0
      @user_one.daysoff.each {|h| sum += h.included_dates().length }
      sum.should == ( 6.0 )
    end
  end
end

describe "getting a list of dates that the user has daysoff for" do

  before(:each) do
    dt = MONDAY_THIS_YEAR
    @user = Factory( :user )
    @dayoff = Factory(    :dayoff,
                      :leave_length => 'many',
                      :user => @user,
                      :begin_time => dt,
                      :end_time   => dt + 2.days )
  end#do

  it "should return a list of a range of days that span a dayoff" do
    @dayoff.included_dates().length.should eql( 3 )
  end

  it "should find a day that is in range of a dayoff" do
    @arb_day = TUESDAY
    @dayoff.included_dates.include?( @arb_day ).should eql( true )
    @arb_day = FRIDAY
    @dayoff.included_dates.include?( @arb_day ).should eql( false )
  end

  it "should return the begin_date for half-day daysoff" do
    @h = Factory(   :dayoff,
                 :leave_length => 'half',
                 :user => @user,
                 :begin_time   =>  FRIDAY,
                 :end_time     =>  nil)
    @h.included_dates.include?( FRIDAY ).should eql( true )
    @h.included_dates.length.should eql( 1 )
  end
end

describe "removing weekends from dayoff range" do
  before(:each)do
    friday  = DateTime.now.change(:year => 2009, :month => 5, :day => 8 )
    tuesday = DateTime.now.change(:year => 2009, :month => 5, :day => 12)

    @dayoff = Factory( :dayoff,
                      :leave_length =>  'many',
                      :begin_time =>  friday,
                      :end_time   =>  tuesday )
  end
  it "should remove saturday and sunday from a holiday's range" do
    @dayoff.get_length.should == 3.0
  end
end
