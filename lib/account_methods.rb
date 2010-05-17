module AccountMethods
  protected
    def current_host
      request.host  
    end
    
    def current_account_owned_by?(user)
      current_account.owner_id == user.id
    end
    
    def current_account
      @current_account ||= Account.find_by_subdomain(account_subdomain)
    end
    
    def default_account_subdomain
      account_subdomain if ["www", ""].include?(account_subdomain)
    end
    
    def default_account_url( use_ssl = request.ssl? )
      http_protocol(use_ssl) + account_domain
    end

    def account_subdomain
      request.subdomain
    end
    
    def account_domain
      request.domain
    end

    def subdomain?
      request.subdomain.nil?
    end

    def http_protocol( use_ssl = request.ssl? )
      (use_ssl ? "https://" : "http://")
    end
    
end
