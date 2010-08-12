class NewDayoffMailJob < Struct.new(:dayoff_id)
  def perform
    dayoff = Dayoff.find(dayoff_id)
    if dayoff.pending?
      DayoffMailer.deliver_new_request_message_for_manager(dayoff)
    end
  end
end
