class DayoffMailer < ActionMailer::Base
  
  def denied_message(dayoff)
    recipients dayoff.user.email
    from "Time Off System <donotreply@timeoffhq.com>"
    subject "Time Off Request Denied"
    sent_on Time.now
    body :dayoff => dayoff
  end

end
