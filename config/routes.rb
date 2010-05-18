ActionController::Routing::Routes.draw do |map|

  map.subdomain :www, :namespace => nil, :name => 'system' do |www|
    www.root      :controller => 'pages', :action => 'show', :id => 'index'
    www.resources :accounts, :only => [:new, :create]
  end

  map.subdomain :model => :account, :namespace => nil, :name => 'subdomain' do |account|
    account.resources :accounts, 
      :only => [:edit, :update, :show, :delete], 
      :as => 'account-information',
      :has_many => :users
    account.resource  :user_session
    #account.resources :users
  end

  map.root :controller => "pages",
    :action => "show",
    :id => "index"

  map.resources :pages,
    :controller => 'pages',
    :only => [:show]

end
