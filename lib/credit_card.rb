class CreditCard
  attr_accessor :name, :number, :cvv, :expiration_month, :expiration_year
  def initialize(attributes={})
    attributes.each do |k,v|
      self.send("#{k}=",v)
    end
  end
end
