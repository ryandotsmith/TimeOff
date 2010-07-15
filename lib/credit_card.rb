class CreditCard
  attr_accessor :name, :number, :cvv, :expiration_date
  def initialize(attributes={})
    attributes.each do |k,v|
      self.send("#{k}=",v)
    end
  end
end
