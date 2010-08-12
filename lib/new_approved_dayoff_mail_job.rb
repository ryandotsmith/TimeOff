class NewApprovedDayoffMailJob < Struct.new(:dayoff_id)
  def perform
    dayoff = Dayoff.find(dayoff_id)
    DayoffMailer.deliver_approved_message(dayoff)
  end
end
