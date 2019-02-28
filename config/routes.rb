Rails.application.routes.draw do

  get '/' => 'store#index', as: 'home'
  get '/products' => 'store#products', as: 'browse_products'
  get '/products/:id' => 'store#product_details', as: 'product'
  get '/categories/:id' => 'store#categories', as: 'browse_category'
  get '/brands/:id' => 'store#brands', as: 'browse_brand'

  get '/cart' => 'cart#index', as: 'cart'
  post '/cart/add' => 'cart#create', as: 'add_to_cart'
  post '/cart/remove/:id' => 'cart#delete', as: 'remove_from_cart'

  get '/login' => 'session#new', as: 'login'
  post '/login' => 'session#create'
  get '/logout' => 'session#destroy', as: 'logout'

  get '/register' => 'accounts#new', as: 'register'
  post '/register' => 'accounts#create', as: 'create_customer'

  get '/orders' => 'orders#index', as: 'orders'
  get '/orders/checkout' => 'orders#checkout', as: 'checkout'
  post '/orders/create' => 'orders#create', as: 'create_order'
  post '/orders/add_shipping' => 'orders#add_shipping', as: 'add_shipping'
  post '/orders/add_payment' => 'orders#add_payment', as: 'add_payment'
  get '/orders/:id' => 'orders#show', as: 'order'
  post '/orders/refund/:id' => 'orders#refund', as: 'refund'



  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
end
