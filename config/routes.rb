ActionController::Routing::Routes.draw do |map|
  map.root :controller => "user_sessions", :action => "new" 
  map.resources :accounts
  map.resources :users
  map.resource  :user_sessions
end
