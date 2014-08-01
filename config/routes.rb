Holachef::Application.routes.draw do
  namespace :cms  do content_blocks :food_items end

  resources :hola_users
  match "/add_chef_to_favorite"=> "hola_users#add_chef_to_favorite"
  match '/my_favorite_chefs'=>"hola_users#my_favorite_chefs"
  match "/add_recipe_to_favorite"=> "hola_users#add_recipe_to_favorite"
  match '/recipes'=> "hola_users#recipes"
  match '/signature_dishes'=> "hola_users#signature_dishes"
  match '/talk_to_us'=> "hola_users#talk_to_us"

  match "/cms" => "cms/dashboard#index"
  match '/review_order' => 'ordered_menus#checkout', :as => :review_order

  match '/recipe/:id'=>'Cms::food_items#show_recipe'
  match '/signature/:dish_name'=> 'Cms::food_items#signature_dishes', :as => :signature_dish
  match '/update_ratings' => "Cms::food_items#update_ratings"

  match '/create_signature_order'=>"Cms::orders#create_signature_order"

  namespace :cms  do
    match '/cheffs/load_dishes'=>'cheffs#load_dishes'
    match '/cuisine_geographies/load_sub_cuisines'=>'cuisine_geographies#load_sub_cuisines'
    match '/cuisine_geographies/load_parent_cuisine'=>'cuisine_geographies#load_parent_cuisine'
    match '/cuisine_geographies/delete/:id' =>'cuisine_geographies#delete_cuisine'
    content_blocks :cheffs
    content_blocks :cooking_todays
    content_blocks :orders
    content_blocks :sub_menus
    content_blocks :cuisine_geographies
    content_blocks :cuisine_styles
  end

  resources :social_shares do

  end

  match '/tell_friends' => 'social_shares#tell_friends'
  post '/send_referal_email' => 'social_shares#send_referal_email'

  match '/orders/set_cart'=> 'Cms::orders#set_cart'
  match '/orders/remove_from_cart'=> 'Cms::orders#remove_from_cart'
  post '/payment-method'=>"Cms::orders#payment_gateway"
  match '/order-confirm/:order_id'=>"Cms::orders#order_confirm"

  match '/cooking_todays/get_review_order_details'=> 'Cms::cooking_todays#get_review_order_details'
  match '/cooking_todays/get_item_details'=> 'Cms::cooking_todays#get_item_details'
  match '/cooking_todays/total_calculation'=> 'Cms::cooking_todays#total_calculation'
  match '/cooking_todays/delete_item'=> 'Cms::cooking_todays#delete_item'

  #resources :home do
  match '/chef-profile/:chef_id'=>'Cms::cheffs#show_details'

  match '/desktop' => 'home#desktop'

  match '/mobile' => 'home#mobile', :as => :home

  match '/submit_payment_form'=> 'Cms::orders#submit_payment_form'
  post "orders/callback"=>'Cms::orders#callback'

  match '/home/index_call' =>'home#index_call'

  post '/email' => 'temporary_home#send_mail'
  post '/feedback' => 'home#feedback'

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
  root :to => 'temporary_home#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'

  mount_browsercms
end
