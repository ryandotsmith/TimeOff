module Subdomain::AccountsHelper
  def account_messages(user)
    messages = []
    pr = user.pending_requests.length
    message = NotificationMessage.new
    message.title = "#{pluralize(pr,'request')} pending approval"
    message.body  = pr
    messages << message

    messages.each {|m| yield m }
  end
end
