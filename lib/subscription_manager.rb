class SubscriptionManager
  def self.client
    @client ||= Chargify::Client.new('ra8u5PSLurINVOgIYqFd', 'wonderset')
  end
end
