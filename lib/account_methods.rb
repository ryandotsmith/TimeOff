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
      #see subdomain_fu
      current_subdomain 
    end
    
    def account_domain
      #see subdomain_fu
      current_domain 
    end

    def subdomain?
      #see subdomain_fu
      current_subdomain 
    end

    def http_protocol( use_ssl = request.ssl? )
      (use_ssl ? "https://" : "http://")
    end
    
    # TODO: Make account_url and account_host methods work
    # def account_url(account_subdomain = default_account_subdomain, use_ssl = request.ssl?)
    #   http_protocol(use_ssl) + account_host(account_subdomain)
    # end
    # 
    # def account_host(subdomain)
    #   account_host = ''
    #   account_host << subdomain + '.'
    #   account_host << account_domain
    # end

end
