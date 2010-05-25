class NotificationMessage
  attr_accessor :title, :body
  def alt
    @title.to_s + " " + @body.to_s
  end
end
