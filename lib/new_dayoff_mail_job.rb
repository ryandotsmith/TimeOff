class NewDayoffMailJob < Struct.new(:dayoff_id)
  def perform
    DayoffMailer.deliver_new_request_message_for_manager(Dayoff.find(dayoff_id))
  end
end
