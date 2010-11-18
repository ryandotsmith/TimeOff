class NotifyOnNewAccountJob < Struct.new(:account_id)
  def perform
    DayoffMailer.deliver_approved_message(Dayoff.find(dayoff_id))
  end
end
