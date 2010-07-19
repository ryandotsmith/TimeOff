module SubscriptionHelper

  module ClassMethods
    def available_products
      SubscriptionManager.client.list_products
    end
  end

  module InstanceMethods
    def create_subscription(credit_card)
      return update_subscription(credit_card) if subscription
      Account.transaction do
        subscription = SubscriptionManager.client.create_subscription(build_params(credit_card))
        if subscription.errors.nil?
          self.update_attributes(:customer_id => subscription.customer.id, :subscription_id => subscription.id)
        else
          subscription.errors.each {|err| errors.add_to_base(err)}
          false
          raise ActiveRecord::Rollback
        end
      end
    end

    def update_subscription(credit_card)
      debugger
    end

    def update_product
      SubscriptionManager.client.update_subscription(subscription_id,{:product_handle => product_handle})
    end

    def subscription
      @subscription ||= SubscriptionManager.client.subscription(subscription_id)
    end

    def has_active_subscription?
      ! expired_subscription?
    end

    def expired_subscription?
      state = subscription.state
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
      SubscriptionManager.client.customer(customer_id)
    end

    def build_params(credit_card)
      if customer.success?
        subscription_params(credit_card).merge(:customer_id => customer_id)
      else
        subscription_params(credit_card).merge(:customer_attributes => customer_params)
      end
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
        :product_handle      => product_handle,
        :credit_card_attributes => {
          :full_number      => credit_card.number,
          :cvv              => credit_card.cvv,
          :expiration_month => credit_card.expiration_month,
          :expiration_year  => credit_card.expiration_year
        }
      }
    end

  end
end
