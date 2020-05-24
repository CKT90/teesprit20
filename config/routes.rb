Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => "/sidekiq"
  
  mount ActionCable.server => '/cable'

  get '/robots.:format' => 'pages#robots'
  
  namespace :admin do
    root :to => redirect('/admin/orders')

    resources :messages

    resources :orders do
      get 'manage_order' => "orders#manage_order"
      post "update_order_payment_status" => "orders#update_order_payment_status"
      post "update_order_shipment_status" => "orders#update_order_shipment_status"
      post "update_order_payment_remarks" => "orders#update_order_payment_remarks"
      post "update_order_shipment_remarks" => "orders#update_order_shipment_remarks"
      put "remove" => "orders#remove"
    end

    resources :users
    resources :products
    resources :categories, only: [:new, :index, :create, :update, :destroy]
    post "update_ot" => "product_option_types#update"
    post "update_ot_test/:product_id/:option_type_id" => "product_option_types#update_two"
    get  "deleted_index" => "orders#deleted_index"
    get  "deleted_product_index" => "products#deleted_index"
    get  "report"  => 'orders#sales_report'
    get "new_display" => 'settings#new_display'

    resources :products do
      put "remove" => "products#remove"
      put "revive" => "products#revive"
      resources :variants, only: [:show, :edit, :update] do
        resources :images
          # collection do
          #   post :update_variant_image_positions
          # end
      end

      resources :images
      #get   "variant_create" => "variants#new", :as => "variant_create"
      #post  "variant_create" => "variants#create"
      #get   "variant_update" => "variants#edit", :as => "variant_update"
      #atch  "variant_update" => "variants#update"
      get "variant_management" => "variants#manage"
      get "property_management" => "products#manage_properties"
      post "update_variant_status" => "variants#update_active_status" 
      
 
      collection do
        post :update_image_positions
      end

      collection do
        post :update_properties_positions
      end
    end


   

    resources :option_types, only: [:new, :index, :create, :update, :edit] do
      resources :option_values
      collection do
        post :update_options_positions
        post :update_values_positions
      end
    end
  end

  resources :line_items do
    collection do 
      put :update_multiple
    end
  end
  
  root               'static_pages#home'
  get   'home'    => 'static_pages#home'
  get   'refund'  => 'static_pages#refund'
  get   'about'   => 'static_pages#about'
  get   'payment' => 'static_pages#pay_method'
  get   'details' => 'static_pages#about_product'
  get   'contact' => 'static_pages#contact'

  get   'chat'    => 'rooms#show'

  get   'resend_validation'=> 'users#resend_validation'
  post  'resend_va' =>'users#resend_validation_action'
  get   "signup"  => "users#new", :as => "signup"
  post  "signup"  => "users#create"
  get   "order_create"  => "orders#new", :as => "order_create"
  post  "order_create"  => "orders#create"
  get   'login'   => 'sessions#new'
  post  'login'   => 'sessions#create'
  post  'addcart' => 'line_items#create'
  delete'logout'  => 'sessions#destroy'
  get   'store'   => 'store#index'
  get   'checkstock' => 'products#check_stock'
  post  'paypal'  => 'orders#process_paypal'
  get   'password_resets/new'
  get   'password_resets/edit'
  get   'stripe_checkout' => 'stripe_checkouts#stripe_checkout_session'

  mount StripeEvent::Engine, at: '/stripe_hook'
 
  resources :products, only: [:show]
  resources :messages, only: [:new, :create]
  resources :users, only: [:new, :create, :update, :edit]
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :store, only: [:index]
  resource  :cart, only: [:index, :show, :destroy]
  resources :orders, only: [:new, :index, :create, :show]
  resource :payment_notification, only: [:create]

  #get "*path" => redirect("/") #redirect invalid url

end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
 
  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

