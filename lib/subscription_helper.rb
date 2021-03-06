module SubscriptionHelper

  module TestMethods
    def self.build_url(path)
      "https://ra8u5PSLurINVOgIYqFd:x@wonderset.chargify.com/#{path}"
    end

    def self.fixture_file(filename)
      return '' if filename == ''
      file_path = File.join(File.dirname(__FILE__),'..','spec', 'fixtures', filename)
      File.read(file_path)
    end

    def self.stub_get(path, filename, status=nil)
      url = build_url(path)
      options = {:body => fixture_file(filename)}
      options.merge!({:status => status}) unless status.nil?
      FakeWeb.register_uri(:get, url, options)
    end

    def self.stub_active_subscription(id)
      FakeWeb.clean_registry
      stub_get "subscriptions/#{id}.json", "active_subscription.json"
    end

    def self.stub_expired_subscription(id)
      FakeWeb.clean_registry
      stub_get "subscriptions/#{id}.json", "expired_subscription.json"
    end

    def self.stub_products
      stub_get "products.json", "products.json"
    end
  end


  module ClassMethods

    def available_products
      SubscriptionManager.list_products
    end

    def subscription(subscription)
      SubscriptionManager.subscription(subscription.subscription_id)
    end

  end

  module InstanceMethods

    def create_subscription!
      Account.transaction do
        subscription = SubscriptionManager.create_subscription(create_subscription_params)
        if subscription.errors.nil?
          self.update_attributes(
            :customer_id => subscription.customer.id,
            :subscription_id => subscription.id)
        else
          subscription.errors.each {|err| errors.add_to_base(err)}
          false
          raise ActiveRecord::Rollback
        end
      end
    end

    def update_subscription_product!
      SubscriptionManager.update_subscription(
        subscription_id,{:product_handle => product_handle}
      )
    end

    def update_credit_card!(new_credit_card)
      subscription = SubscriptionManager.update_subscription(
        subscription_id,{:credit_card_attributes => new_credit_card.to_param }
      )
      if subscription.success?
        true
      else
        subscription.errors.each {|err| errors.add_to_base(err)}
        false
      end
    end

    def subscription
      Account.subscription(self)
    end

    def state
      subscription.state
    end

    def has_active_subscription?
      ! expired_subscription?
    end

    def trial_subscription?
      state == "trialing"
    end

    def expired_subscription?
      state == "expired" ||
      state == "cancled" ||
      state == "suspended"
    end

    def days_remaining_in_trial
      Date.parse(subscription.trial_ended_at) - Date.today
    end

    def credit_card
      subscription.credit_card if subscription
    end

    def credit_card_number
      credit_card.masked_card_number if credit_card
    end

    def customer
      SubscriptionManager.customer(customer_id)
    end

    def create_subscription_params
      {
        :product_handle => Account::DEFAULT_PRODUCT,
        :customer_attributes => {
          :first_name   => owner.first_name,
          :last_name    => owner.last_name,
          :email        => owner.email,
          :reference    => id,
          :organization => company_name,
        }
      }
    end
  end
end
