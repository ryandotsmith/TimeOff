class SubscriptionManager

  Rails.env == "production" ? CHARGIFY_DOMAIN = "timeoffhq" : CHARGIFY_DOMAIN = "wonderset"

  def self.update_subscription(subscription_id,opts)
    client.update_subscription(subscription_id,opts)
  end

  def self.create_subscription(opts)
    client.create_subscription(opts)
  end

  def self.customer(customer_id)
    client.customer(customer_id)
  end

  def self.list_products
    client.list_products
  end

  def self.subscription(id)
    client.subscription(id)
  end

  private

    def self.client
      Chargify::Client.new('ra8u5PSLurINVOgIYqFd', CHARGIFY_DOMAIN)
    end

end
