class CreditCard

  attr_accessor :first_name,:last_name, :number, :cvv, :expiration_month, :expiration_year

  def initialize(attributes={})
    attributes.each do |k,v|
      self.send("#{k}=",v)
    end
  end

  def to_param
    {
      :full_number      => number,
      :cvv              => cvv,
      :expiration_month => expiration_month,
      :expiration_year  => expiration_year,
      :first_name       => first_name,
      :last_name        => last_name
    }
  end

end
