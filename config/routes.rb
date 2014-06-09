Holachef::Application.routes.draw do

  match "/cms" => "cms/dashboard#index"
  match '/review_order' => 'ordered_menus#checkout', :as => :review_order

  namespace :cms  do
    match '/cheffs/load_dishes'=>'cheffs#load_dishes'
    content_blocks :cheffs
    content_blocks :dishes
    content_blocks :cooking_todays
    content_blocks :orders
  end

  match '/orders/set_cart'=> 'Cms::orders#set_cart'
  match '/cooking_todays/get_menu_details'=> 'Cms::cooking_todays#get_menu_details'
  match '/cooking_todays/get_item_details'=> 'Cms::cooking_todays#get_item_details'

  #resources :home do
  match '/chef-profile/:chef_id'=>'Cms::cheffs#show_details'
  match '/payment-method'=>"Cms::orders#payment_gateway"
  #end

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'home#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'

  mount_browsercms
end
