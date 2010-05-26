module Subdomain::AccountsHelper
  def account_messages(account,user)
    messages = []

    data = user.pending_requests.length
    message = NotificationMessage.new
    message.title = "#{pluralize(data,'request').split(" ").last} pending approval"
    message.body  = data
    messages << message

    data = account.daysoff.pending.count
    message = NotificationMessage.new
    message.title = requests_needs(data) + " approval"
    message.body  = data
    messages << message

    data = user.get_remaining_dayoff_time[:vacation]
    message = NotificationMessage.new
    message.title = "vacation days remaining"
    message.body  = data
    messages << message

    messages.each {|m| yield m }
  end

  def requests_needs(qty)
    qty == 1 ? 'request needs' : 'requests need' 
  end

end
