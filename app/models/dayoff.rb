class Dayoff < ActiveRecord::Base
  # 0.1875 != 0.5 , nevertheless, these calculations were decided
  # to be accurate based upon our business logic. 
  HALF_DAY  = 0.1875
  WHOLE_DAY = 0.3958

  belongs_to :account
  belongs_to :user

  validate :prohibit_time_travel
  validate_on_create :not_nice_twice

  validates_presence_of :begin_time,  :message => "please specify beginning time"
  validates_presence_of :description, :message => "please add a descirption"

  named_scope :approved, :conditions => {:state => 1 }
  named_scope :pending,  :conditions => {:state => 0 }
  named_scope :denied,   :conditions => {:state => -1}

  def before_validation
    adjust_time!( self.leave_length )
    sanitize_input!
  end

  # i expect search to only be called in code when the search parameter 
  # is built. I am not ready to have the search parameter be user input.
  def self.search(search, page)
    user = User.find_by_login(search)
    return paginate( :per_page => 20, :page => page,:order => "created_at DESC" ) if user.nil?
    paginate :per_page => 20, :page => page,
             :conditions => ['user_id like ?', "%#{user.id}%"], :order => 'user_id'
  end
 
  def self.get_leave_ratio
    max   = User.get_total_dayoff_time()
    taken = Dayoff.get_taken_leave()
    max / taken
  end

  def self.get_taken_leave()
    sum = 0.0
    Dayoff.find(:all).each do |dayoff|
      if dayoff.state == 1
        sum += dayoff.get_length()
      end
    end
    sum
  end
    
  def self.get_dayoff_types
    ["etc","personal","vacation"]  
  end

  def prohibit_time_travel
    errors.add_to_base "Time travel is strictly prohibited! Correct ending date." if
      !begin_time.nil? and end_time < begin_time
  end
 
  def not_nice_twice
    if !begin_time.nil? and in_range_of_existing
      errors.add_to_base "This request contains a day that already belongs to one of your holidays."
    end 
  end
 
  def in_range_of_existing
    (self.user.get_list_of_dates & self.included_dates) != []
  end

  def sanitize_input!
    self.description = Sanitize.clean( self.description )
  end
 
  def self.get_pending
    Dayoff.find_all_by_state(0).to_a
  end
  
  def self.update_calendar( dayoff_input, action )
    dayoff = Dayoff.find( dayoff_input.id )
    dayoff.push_to_calendar if
      action.to_sym == :push
    dayoff.delete_from_calendar if
      action.to_sym == :delete
  end

  def pending?
    state == 0
  end
  
  def approved?
    state == 1
  end

  def denied?
    state == -1 
  end

  def approve( current_user )
    self.reviewed_by = current_user.name
    self.reviewed_on = DateTime.now
    self.state       = 1
    self.save!
  end

  def deny( current_user )
    self.reviewed_by = current_user.login
    self.reviewed_on = DateTime.now
    self.state       = -1
    self.save!
  end
 
  ####################
  # get_length should get called any time that you need
  # to display the length of a holiday. Since the DB only 
  # holds a begin and end DateTime, you can add methods similar to this one 
  # to represent holiday length in a view. 
  #
  # This particular method will subtract the dates (which will yield the diff in sec)
  # and then convert the difference to a float.
  def get_length()
    length      = 0.0
    difference  = ( self.end_time.to_datetime - self.begin_time.to_datetime).to_f
    # approx is a monkey patch ( look out ). it uses the concept of epsilon math. 
    if difference.approx( HALF_DAY, 0.01)
      length = 0.5
    elsif difference.approx( WHOLE_DAY, 0.01)
      length = 1.0
    else 
      self.included_dates.each {|date| length += 1.0 if date.working_day? }
    end
    length
  end

  def adjust_time!( type )
    return if self.begin_time.nil?
    case type
    when 'half'
      self.begin_time = self.begin_time.to_datetime.change( :hour => 7,  :min => 30 )
      self.end_time   = self.begin_time.to_datetime.change( :hour => 12, :min => 00 )
    when 'whole'
      self.begin_time = self.begin_time.to_datetime.change( :hour => 7, :min => 30 )
      self.end_time   = self.begin_time.to_datetime.change( :hour => 17, :min => 00 )
    when 'many'
      self.begin_time = self.begin_time.to_datetime.change( :hour => 7, :min => 30 )
      self.end_time   = self.end_time.to_datetime.change( :hour => 17, :min => 00 )
    end
  end

  # returns a list of dates that are 
  # the days between and including the begin_time and end_time
  def included_dates
    array = []
    begin_time.to_date.upto(end_time.to_date) do |date|
      array << date if date.working_day?
    end
    array
  end

end
