ActionController::Routing::Routes.draw do |map|

  map.root :controller => "pages",:action => "show",:id => "index", :conditions => {:subdomain => /.+/}
  map.resources :pages,:controller => 'pages',:only => [:show],     :conditions => {:subdomain => nil}

  map.resource  :account, :conditions => {:subdomain => /.+/} do |a|
    a.resources :users
  end
  map.resources :users, :conditions => {:subdomain => true} 
  map.resource :user_session, :conditions => {:subdomain => true} 

  map.login '/login/',   :controller => "user_sessions", :action => "new",     :conditions => {:subdomain => /.+/}
  map.logout '/logout/', :controller => "user_sessions", :action => "destroy", :conditions => {:subdomain => /.+/}

  map.application_root "/", 
    :controller => "accounts", 
    :action => "show",  
    :conditions => {:subdomain => /.+/}

  map.public_root      "/", 
    :controller => "pages",    
    :action => "show", 
    :id => 'index', 
    :conditions => {:subdomain => nil}
 
end
