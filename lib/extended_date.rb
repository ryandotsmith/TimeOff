class Date
  def working_day?
    self.wday != 6 and self.wday != 0 
  end
end
