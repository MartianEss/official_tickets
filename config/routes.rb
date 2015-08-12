Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'events#index'

  get '/customer_services' => 'customer_services#index', as: :customer_services_root
  get '/event_managers' => 'event_managers#index', as: :event_managers_root

  devise_for :event_managers, path: 'event_managers'
  devise_for :customer_services, path: 'customer_services'
  devise_for :ticket_purchaser, path: 'ticket_purchasers'

  # Customer Services based resources
  namespace :customer_services do
    resources :event_managers, except: [:new, :create]
    resources :events, except: [:new, :create]
  end

  resources :tickets, only: [:index]

  # Event Manager based resources
  namespace :event_managers do
    resources :events, as: :events do
      resources :tickets_allocations, only: [:index, :new, :create, :show] do
        resource :ticket, only: [:index] do
          post 'used'
        end
      end
    end
  end

  patch "/event_managers/events" => "event_managers/events#update"

  # Ticket purchaser based resources
  resources :events, only: [:index, :show] do
    resources :tickets_allocations, only: [], as: :tickets do
      resources :orders, only: [:new, :create, :show], as: :orders
    end
  end

  get 'orders' => 'orders#index'

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
