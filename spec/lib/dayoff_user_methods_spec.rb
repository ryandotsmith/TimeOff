require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe DayoffUserMethods do
  before(:each) { @user   = Factory(:user) }

  describe "returns statistical data" do
    it "should return pending requests" do
      dayoff = Factory(:dayoff,:user => @user)
      @user.daysoff << dayoff
      @user.save

      @user.pending_requests.should eql([dayoff])
    end
  end

  describe "querying daysoff" do
    context "for this year" do
      it "should not include last years" do
        dayoff = Factory(:dayoff,:user => @user)
        dayoff.begin_time = DateTime.now - 1.year
        dayoff.end_time   = (DateTime.now - 1.year) + 1.day

        @user.daysoff << dayoff
        @user.save

        @user.this_years_daysoff.should_not include dayoff
        @user.daysoff.should include dayoff
      end
      it "should not inlcude next years" do
        dayoff = Factory(:dayoff,:user => @user)
        dayoff.begin_time = DateTime.now + 1.year
        dayoff.end_time   = (DateTime.now + 1.year) + 1.day

        @user.daysoff << dayoff
        @user.save

        @user.this_years_daysoff.should_not include dayoff
        @user.daysoff.should include dayoff
      end
    end
  end





  context 'legacy specs' do
    describe "Provide valuable statistics on dayoff data" do

      before(:each) do
        date_time = MONDAY_THIS_YEAR
        @user = Factory( :user )
        @h1   = Factory(  :dayoff,
                          :leave_length  => 'many',
                          :state => 1 , 
                          :user => @user,
                          :begin_time => date_time,
                          :end_time   => date_time + 2.days)
        @h2   = Factory(  :dayoff,
                          :leave_length => 'many',
                          :state => 1 , 
                          :user => @user,
                          :begin_time => date_time + 7.days,
                          :end_time   => date_time + 9.days)
        @h3   = Factory(  :dayoff,
                          :leave_length => 'many',
                          :state => 1, 
                          :leave_type => 'vacation', 
                          :user => @user,
                          :begin_time => date_time + 14.days,
                          :end_time   => date_time + 16.days)
        @user.daysoff << @h1
        @user.daysoff << @h2
        @user.daysoff << @h3
      end

      it "should return a list of dates of days included in all of user's daysoff" do
        # since the daysoff created in the before block have unique calendars days,
        # and each dayoff has 2 calendars days, the list of dates should containt 
        # 6 dates. 
        @user.get_list_of_dates.length.should eql( 9 )
        @user.get_list_of_dates.first.class.should eql( Date )
      end
      it "should only take into account unique calendar days" do
        # this should not be an issue. A dayoff that is created will 
        # fail validation if the given dayoff
        
      end

      it "should return the number of days taken on dayoff" do
        ordered_dictionary = Dictionary.new
        ordered_dictionary[:etc] = 6.0
        ordered_dictionary[:personal] = 0
        ordered_dictionary[:vacation] = 3.0
        @user.daysoff.length.should eql( 3 )
        @user.get_total_dayoff_time.should eql( 9.0 )
        @user.get_taken_dayoff_time.should == ordered_dictionary
      end
      
      it "should return a hash of daysoff with the number of days the user has taken" do
        ordered_dictionary = Dictionary.new
        ordered_dictionary[:etc] = 4.0
        ordered_dictionary[:personal] = 10.0
        ordered_dictionary[:vacation] = 7.0
        @user.daysoff.length.should eql( 3 )
        @user.get_total_dayoff_time.should eql( 9.0 )
        @user.get_remaining_dayoff_time.should == ordered_dictionary    
      end
      
      it "should return a hash of daysoff with the number of days the user has left" do
        ordered_dictionary = Dictionary.new
        ordered_dictionary[:etc] = 4.0
        ordered_dictionary[:personal] = 10.0
        ordered_dictionary[:vacation] = 7.0
        @user.daysoff.length.should eql( 3 )
        @user.get_total_dayoff_time.should eql( 9.0 )
        @user.get_remaining_dayoff_time.should == ordered_dictionary
      end
    end

    describe "fetching daysoff that were taken in the current year" do
      it "should select daysoff with begin_time > the first of the current year" do
        last_year = Date.new(2009,1,19) #monday
        this_year = Date.new(2010,1,4)  #monday
        @user    = Factory(:user)
        @dayoff1= Factory(:dayoff,:user => @user,:begin_time => last_year,:end_time => last_year+1.day)
        @dayoff2= Factory(:dayoff,:user => @user,:begin_time => this_year,:end_time => this_year+1.day)
        @user.daysoff << @dayoff1
        @user.daysoff << @dayoff2
        @user.this_years_daysoff.should eql([@dayoff2]) 
      end
    end
    describe "Calculating a user's daysoff" do
      before(:each) do
        last_year = Date.new(2009,1,19) #monday
        this_year = Date.new(2010,1,4)  #monday
        @user    = Factory(:user)
        @dayoff1= Factory(:dayoff,:user => @user,:begin_time => last_year,:end_time => last_year+1.day)
        @dayoff2= Factory(:dayoff,:user => @user,:begin_time => this_year,:end_time => this_year+1.day)
        [@dayoff1,@dayoff2].map {|h| h.state == 1 and h.save}
      end
      it "should only count daysoff that were taken during the current year" do
      end
    end
  end
end
