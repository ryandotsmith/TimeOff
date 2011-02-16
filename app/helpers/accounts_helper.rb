module AccountsHelper
  def account_messages(account,user)
    messages = []
    account.dayoff_types.each do |type|
      data = user.get_remaining_dayoff_time[type]
      max  = user.send("max_#{type}")
      message = NotificationMessage.new
      message.title = "#{type} days remaining <br /> out of <span>#{max}</span>"
      message.body  = data
      messages << message
    end
    messages.each {|m| yield m }
  end

  def requests_needs(qty)
    qty == 1 ? 'request needs' : 'requests need'
  end

end
