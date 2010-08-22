class NewApprovedDayoffMailJob < Struct.new(:dayoff_id)
  def perform
    DayoffMailer.deliver_approved_message(Dayoff.find(dayoff_id))
  end
end
