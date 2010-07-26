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

    def update_subscription!(opts={})
      new_credit_card  = opts[:credit_card]
      update_credit_card(new_credit_card) if new_credit_card
      update_subscription_product(self.product_handle)
    end

    def update_credit_card(credit_card)
      SubscriptionManager.update_subscription(subscription_id,{:credit_card_attributes => credit_card.to_param })
    end

    def update_subscription_product(product_handle)
      SubscriptionManager.update_subscription(subscription_id,{:product_handle => product_handle})
    end

    def subscription
      Account.subscription(self)
    end

    def state
      return "trialing" if RAILS_ENV == 'development'
      subscription.state
    end

    def has_active_subscription?
      ! expired_subscription?
    end

    def expired_subscription?
      state == "expired" ||
      state == "cancled" ||
      state == "suspended"
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

    def build_params(credit_card)
      if customer.success?
        subscription_params(credit_card).merge(:customer_id => customer_id)
      else
        subscription_params(credit_card).merge(:customer_attributes => customer_params)
      end
    end

    def create_subscription_params
      {
        :product_handle => "0-5-users",
        :customer_attributes => {
          :first_name   => owner.first_name,
          :last_name    => owner.last_name,
          :email        => owner.email,
          :reference    => id,
          :organization => company_name,
        }
      }
    end

    def customer_params
      {
        :first_name   => owner.first_name,
        :last_name    => owner.last_name,
        :email        => owner.email,
        :reference    => id,
        :organization => company_name,
      }
    end

    def subscription_params(credit_card)
      {
        :product_handle         => product_handle,
        :credit_card_attributes => (credit_card.to_param if credit_card)
      }
    end

  end
end
