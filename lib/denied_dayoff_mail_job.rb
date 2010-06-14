class DeniedDayoffMailJob < Struct.new(:dayoff_id)
  def perform 
    DayoffMailer.deliver_denied_message(Dayoff.find(dayoff_id))     
  end
end
