class Email

  attr_accessor :from, :to, :subject, :body

  def initialize(attributes={})
    attributes.each {|k,v| self.send("#{k}=",v)}
  end

  def act!
    if approved?
      dayoff.approve(manager)
    else
      dayoff.deny(manager)
    end
  end

  def approved?
    body[0..14].include?("approve")
  end

  def denied?
    body[0..14].include?("deny")
  end

  def dayoff
    Dayoff.find(filtered_dayoff_id)
  end

  def manager
    User.find_by_email(filtered_email_address)
  end

  def filtered_email_address
    return from if from.scan(/\<|\>/).empty?
    from.match(%r{<.*.>})[0].sub("<","").sub(">","")
  end

  def filtered_dayoff_id
    to.match(/\d+/)[0]
  end

end
