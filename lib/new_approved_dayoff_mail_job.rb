class NewApprovedDayoffMailJob < Struct.new(:dayoff_id)
  def perform
    raise "here"
    DayoffMailer.deliver_approved_message(Dayoff.find(dayoff_id))
  end
end
