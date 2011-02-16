class BlackOutDay < ActiveRecord::Base
  belongs_to :account

  def to_fullcalendar_format(user)
    {
      :title      => self.description,
      :start      => self.date.iso8601,
      :end        => self.date.iso8601,
      :user_id    => nil,
      :allDay     => true,
      :className  => 'blackout'
    }
  end

end
