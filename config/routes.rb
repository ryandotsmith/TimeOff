ActionController::Routing::Routes.draw do |map|
  map.subdomain :www, :namespace => nil, :name => 'system' do |www|
    www.root      :controller => 'pages', :action => 'show', :id => 'index'
    www.resources :accounts, :only => [:new, :create]
  end

  map.subdomain :model => :account, :name => 'subdomain' do |account|
    account.root :controller => 'user_sessions', :action => 'new' 
    account.resources :accounts, :only => [:show,:edit,:update], :as => 'account-details'
    account.resources :users
    account.resource  :user_session, :only => [:new,:create,:destroy]
  end

end
