ActionController::Routing::Routes.draw do |map|
  map.root      :controller => "pages", 
    :action => "show" , 
    :id => "index"
  map.resources :pages,
    :controller => 'pages',
    :only       => [:show]
  map.resources :accounts
  map.resources :users
  map.resources :user_sessions
end
