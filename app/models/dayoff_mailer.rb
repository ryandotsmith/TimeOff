class DayoffMailer < ActionMailer::Base

  def approved_message(dayoff)
    recipients dayoff.user.email
    from "Time Off <donotreply@timeoffhq.com>"
    subject "Time Off Request Approved"
    sent_on Time.now
    body :dayoff => dayoff
  end

  def new_request_message_for_manager(dayoff)
    recipients dayoff.account.managers.map(&:email)
    from "Time Off <#{dayoff.id}@listen.timeoffhq.com>"
    subject "New Time Off Request"
    sent_on Time.now
    body :dayoff => dayoff, :account => dayoff.account
  end

  def denied_message(dayoff)
    recipients dayoff.user.email
    from "Time Off <donotreply@timeoffhq.com>"
    subject "Time Off Request Denied"
    sent_on Time.now
    body :dayoff => dayoff
  end

  def deleted_message(dayoff)
    recipients dayoff.user.email
    from "Time Off <donotreply@timeoffhq.com>"
    subject "Time Off Deleted"
    sent_on Time.now
    body :dayoff => dayoff
  end

end
