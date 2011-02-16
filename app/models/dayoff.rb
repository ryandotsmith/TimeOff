class Dayoff < ActiveRecord::Base
  # 0.1875 != 0.5 , nevertheless, these calculations were decided
  # to be accurate based upon our business logic.
  HALF_DAY  = 0.1875
  WHOLE_DAY = 0.3958

  require 'state_machine'
  extend StateMachine::ClassMethods
  include StateMachine::InstanceMethods

  belongs_to :account
  belongs_to :user

  validate :prohibit_time_travel
  validate_on_create :not_nice_twice

  validates_presence_of :begin_time,  :message => "please specify beginning time"
  validates_presence_of :description, :message => "please add a descirption"

  named_scope :approved, :conditions => {:state => 1 }
  named_scope :pending,  :conditions => {:state => 0 }
  named_scope :denied,   :conditions => {:state => -1}

  default_scope :order => 'created_at DESC'

  def before_validation
    adjust_time!(self.leave_length)
    sanitize_input!
  end

  def self.paginate_by_creation_date(account,params)
    paginate :all,
      :sort_key   => params[:sort_key]   || "created_at",
      :sort_value => params[:sort_value],
      :sort_id    => params[:sort_id],
      :sort_order => "desc",
      :limit      => 5,
      :include    => :user,
      :conditions => ["account_id = ?",account.id]
  end

  def self.get_dayoff_types
    ["etc","personal","vacation"]
  end

  def prohibit_time_travel
    if begin_time and end_time < begin_time
      errors.add_to_base "Your start date occurs before your end date."
    end
  end

  def not_nice_twice
    if !begin_time.nil? and in_range_of_existing
      errors.add_to_base "This request contains a day that belongs to another approved request."
    end
  end

  def in_range_of_existing
    (self.user.get_list_of_dates & self.included_dates) != []
  end

  def sanitize_input!
    self.description = Sanitize.clean( self.description )
  end

  def whole?
    leave_length == 'whole'
  end

  def approve(current_user)
    self.reviewed_by = current_user.name
    self.reviewed_on = DateTime.now
    self.state       = 1
    Delayed::Job.enqueue(ApprovedDayoffMailJob.new(self.id))
    self.save!
  end

  def deny(current_user)
    self.reviewed_by = current_user.name
    self.reviewed_on = DateTime.now
    self.state       = -1
    Delayed::Job.enqueue(DeniedDayoffMailJob.new(self.id))
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
  def length
    difference = (self.end_time.to_datetime - self.begin_time.to_datetime).to_f
    if difference.approx( HALF_DAY, 0.01)
      0.5
    elsif difference.approx( WHOLE_DAY, 0.01)
      1.0
    else
      included_dates.reject {|d| black_out?(d)}.length.to_f
    end
  end

  def black_out?(date)
    date.working_day? && user.account.black_out_days.map(&:date).include?(date)
  end

  def adjust_time!( type )
    return if self.begin_time.nil?
    case type
    when 'half'
      self.begin_time = self.begin_time.to_datetime.change( :hour => 7,   :min => 30 )
      self.end_time   = self.begin_time.to_datetime.change( :hour => 12,  :min => 00 )
    when 'whole'
      self.begin_time = self.begin_time.to_datetime.change( :hour => 7,   :min => 30 )
      self.end_time   = self.begin_time.to_datetime.change( :hour => 17,  :min => 00 )
    when 'many'
      self.begin_time = self.begin_time.to_datetime.change( :hour => 7,   :min => 30 )
      self.end_time   = self.end_time.to_datetime.change(   :hour => 17,  :min => 00 )
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

  def to_fullcalendar_format(user)
    {
      :title      => self.to_s,
      :start      => self.begin_time.iso8601,
      :end        => self.end_time.iso8601,
      :user_id    => self.user.id,
      :allDay     => self.whole?,
      :className  => (css_class(user)),
      :current_user_is_manager => user.manager?
    }
  end

  def to_icalendar_format(cal)
    dayoff = self
    cal.event do
      dtstart     dayoff.begin_time.to_date
      dtend       dayoff.end_time.to_date
      summary     dayoff.to_s
      description dayoff.description
    end
  end

  def css_class(user)
    (self.user == user and !self.pending?) ? 'yours' : self.status
  end

  def to_s
    user.name
  end

end
