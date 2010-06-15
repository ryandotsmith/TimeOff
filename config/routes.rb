ActionController::Routing::Routes.draw do |map|
  map.root :controller => 'pages', :action => 'show', :id => 'index'

  map.resources :pages, :controller => 'pages', :only => [:show]
  map.resource :user_session

  map.register '/register/:activation_code',  :controller => 'activations', :action => 'new'
  map.activate '/activate/:id',               :controller => 'activations', :action => 'create'

  map.resources :accounts, :shallow => true do |accounts|
    accounts.resources :daysoff
    accounts.resources :users, :has_many => :daysoff
    accounts.calendar '/calendar/:year/:month', :controller => 'calendar', :action => 'index', :year => Time.zone.now.year, :month => Time.zone.now.month
  end
end
