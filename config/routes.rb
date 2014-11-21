Holachef::Application.routes.draw do


  resources :hola_users
  match "/add_chef_to_favorite"=> "hola_users#add_chef_to_favorite"
  match '/my_favorite_chefs'=>"hola_users#my_favorite_chefs"
  match "/add_recipe_to_favorite"=> "hola_users#add_recipe_to_favorite"
  match '/recipes'=> "hola_users#recipes"
  match '/recipes/favourites'=> "hola_users#favourite_recipes"
  match '/signature_dishes'=> "hola_users#signature_dishes"
  match '/signature_dishes/favourites'=> "hola_users#favourite_signature_dishes"

  match "/cms" => "cms/dashboard#index"
  match '/review_order' => 'ordered_menus#checkout', :as => :review_order
  match '/get_address_by_type' => 'ordered_menus#get_address_by_type'

  match '/recipe/:id'=>'Cms::food_items#show_recipe'
  match '/signature/:dish_name'=> 'Cms::food_items#signature_dishes', :as => :signature_dish
  match '/update_ratings' => "Cms::food_items#update_ratings"

  # Added for Posting Review on dish in order history 
  # On 20/11/2014 By Pradnya Kulkarni 
  # Contact: pradnya@sodelsolutions.com
  match '/post_review' => "Cms::food_items#post_review" 
  
  match '/cms/food_items/load_chef_dishes'=>'Cms::food_items#load_chef_dishes'

  match '/create_signature_order'=>"Cms::orders#create_signature_order"
  match '/check_coupon' => "ordered_menus#check_coupon_code", :as => :check_coupon

  namespace :cms  do
    match '/cheffs/load_dishes'=>'cheffs#load_dishes'
    match '/food_items/load_chef_dishes'=>'food_items#load_chef_dishes'
    match '/food_items/delete'=> 'food_items#delete_food_item'
    match '/cuisine_geographies/load_sub_cuisines'=>'cuisine_geographies#load_sub_cuisines'
    match '/cuisine_geographies/load_parent_cuisine'=>'cuisine_geographies#load_parent_cuisine'
    match '/cuisine_geographies/delete/:id' =>'cuisine_geographies#delete_cuisine'
    content_blocks :cheffs
    content_blocks :cooking_todays
    content_blocks :orders
    content_blocks :sub_menus
    content_blocks :cuisine_geographies
    content_blocks :cuisine_styles
    content_blocks :food_items
    content_blocks :runners
    content_blocks :chef_requests
    content_blocks :party_orders
    content_blocks :feedbacks
    content_blocks :coupons
  end

  resources :social_shares do

  end

  match '/tell_friends' => 'social_shares#tell_friends'
  match '/how_it_works' => 'social_shares#how_it_works'
  match '/service_areas' => 'social_shares#service_areas'
  post '/send_referal_email' => 'social_shares#send_referal_email'
  post '/email_invoice/:order_id' => 'Cms::orders#email_invoice'

  match '/orders/set_cart'=> 'Cms::orders#set_cart'
  match '/orders/remove_from_cart'=> 'Cms::orders#remove_from_cart'
  match '/payment-method'=>"Cms::orders#payment_gateway"
  match '/order-confirm/:order_id'=>"Cms::orders#order_confirm"
  match '/show_invoice/:order_id'=> "Cms::orders#show_invoice"
  match '/add-address'=>"Cms::orders#add_address"

  match '/cooking_todays/get_review_order_details'=> 'Cms::cooking_todays#get_review_order_details'
  match '/cooking_todays/get_item_details'=> 'Cms::cooking_todays#get_item_details'
  match '/cooking_todays/total_calculation'=> 'Cms::cooking_todays#total_calculation'
  match '/cooking_todays/delete_item'=> 'Cms::cooking_todays#delete_item'

  #resources :home do
  match '/chef-profile/:chef_id'=>'Cms::cheffs#show_details'

  match '/desktop' => 'home#desktop'
  match '/landing' => 'home#landing'
  match '/add-dishes' => 'home#add_other_dishes'

  match '/', to: 'home#mobile', constraints: lambda { |r| r.subdomain.present? && r.subdomain != 'www' && ['m', 'qam'].include?(r.subdomain)}

  match '/mobile' => 'home#mobile', :as => :home

  match '/submit_payment_form'=> 'Cms::orders#submit_payment_form'
  post "orders/callback"=>'Cms::orders#callback'

  match '/home/index_call' =>'home#index_call'
  match '/logout' =>'home#logout'

  post '/email' => 'temporary_home#send_mail'
  post '/feedback' => 'Cms::feedbacks#feedback'
  match '/talk_to_us'=> "Cms::feedbacks#talk_to_us"

  match '/become-a-chef' => 'Cms::chef_requests#become_chef'
  match '/create_chef' => 'Cms::chef_requests#create_chef'

  match '/party_orders' => 'Cms::party_orders#party_orders'
  match '/create_party_orders' => 'Cms::party_orders#create_party_orders'

  resources :hola_user_addresses, only: [:index, :create, :update]
  match "/new_address" => "hola_user_addresses#new"
  match '/hola_user_addresses/set_default' =>'hola_user_addresses#set_default'
  resources :order_histories, only: [:index]

  resources :hola_session, only: [:create] do
    collection do
      post :confirm_with_otp
      get :confirm_with_otp
      get :regenerate_otp
      get :get_sign_in_details
    end
  end

  namespace :api do
    resources :orders do
      get :update_status
      get :assign_runner
      get :update_menu_item_status
      get :reorder
      get :add_comment
    end

    resources :runners do
      get :orders
    end
    match "/runner/login" => 'runners#authenticate_runner'
  end

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
