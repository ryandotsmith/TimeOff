ActionController::Routing::Routes.draw do |map|

  map.root :controller => 'pages', :action => 'show', :id => 'index'

  map.resources :pages, :controller => 'pages', :only => [:show]
  map.resource :user_session

  map.resources :password_resets, :only => [ :new, :create, :edit, :update ]
  map.register '/register/:activation_code',  :controller => 'activations', :action => 'new'
  map.activate '/activate/:id',               :controller => 'activations', :action => 'create'
  map.sign_in  '/signin',                     :controller => 'user_sessions', :action => 'new'

  map.resources :accounts, :shallow => true do |accounts|
    accounts.resources :daysoff
    accounts.resources :archived_daysoff
    accounts.resources :users, :has_many => :daysoff
    accounts.resource  :billing, :controller => 'billing'
    accounts.calendar '/calendar/:year/:month', :controller => 'calendar', :action => 'index', :year => Time.zone.now.year, :month => Time.zone.now.month
  end

  map.resource :i_cal, :controller => 'i_cal', :only => :show
  map.email_listner '/email_listener', :controller => 'email_listener', :action => 'create'

  HighVoltage::Routes.draw(map)
  map.namespace :root do |root|
    root.resources :accounts
  end
end
