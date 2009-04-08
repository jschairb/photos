ActionController::Routing::Routes.draw do |map|

  map.resource :account, :controller => "users"
  map.resources :users

  map.resource :user_session

  map.resources :photos

  # SIGNUP
  map.signup '/signup', :controller => "users", :action => "new"

  # ACTIVATION
  map.register '/register/:activation_code', :controller => 'activations', :action => 'new'
  map.activate '/activate/:id', :controller => 'activations', :action => 'create'
  map.resources :activations, :collection => { :instructions => :get }

  # PASSWORD RESETS
  map.resources :password_resets

  map.picture "/pictures/:id/:style", :controller => "pictures", :action => "show"

  map.home "/home", :controller => "home", :action => "index"

  map.root :controller => "home"

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

#   map.connect ':controller/:action/:id'
#   map.connect ':controller/:action/:id.:format'
end
