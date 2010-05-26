class NotificationMessage
  attr_accessor :title, :body
  attr_reader :intended_for

  def initialize
    @intended_for = 'everyone' 
  end

  def alt
    @title.to_s + " " + @body.to_s
  end

  def intended_for_admin!
    @intended_for = 'admin' 
  end
  
end
