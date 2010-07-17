module SubscriptionHelper

  module ClassMethods
    def available_products
      Chargify::Product.find(:all)
    end
  end

  module InstanceMethods
    def create_subscription(credit_card)
      return update_subscription(credit_card) if subscription
      Account.transaction do
        subscription = Chargify::Subscription.new(subscription_params(credit_card))
        if subscription.save
          self.update_attributes(:customer_id => subscription.customer.id, :subscription_id => subscription.id)
        else
          subscription.errors.full_messages.each{|err| errors.add_to_base(err)}
          false
          raise ActiveRecord::Rollback
        end
      end
    end

    def update_subscription(credit_card)
      debugger
    end

    def subscription
      @subscription ||= Chargify::Subscription.find(subscription_id)
    end

    def credit_card
      subscription.credit_card
    end

    def customer
      Chargify::Customer.find(customer_id)
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
        :customer_attributes => customer_params,
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
