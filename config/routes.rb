Pixtr::Application.routes.draw do 
  get "/galleries/random" => "random_galleries#show"


  root "homes#show"

  resource :dashboard, only: [:show]

  resources :tags, only: [:show]

  resources :galleries do 
    member do 
      post "like" => "gallery_likes#create"
      delete "unlike" => "gallery_likes#destroy"
    end
    resources :images, shallow: true      
  end

  resources :images, except: [:index, :new, :create] do 
    resources :comments, only: [:create]
    member do 
      post "like" => "image_likes#create"
      delete "unlike" => "image_likes#destroy"
    end
  end

  resources :comments, only: [:destroy]

  

  resources :groups, only: [:index, :new, :create, :show] do 
    member do 
      post "join" => "group_memberships#create"
      delete "leave" => "group_memberships#delete"
      post "like" => "group_likes#create"
      delete "unlike" => "group_likes#destroy"  

    end
  end

  resources :users, only: [:show] do
    member do 
      post "follow" => "following_relationships#create"
      delete "unfollow" => "following_relationships#destroy"
    end
  end



  # get "/galleries/new" => "galleries#new"
  # get "/galleries/:id" => "galleries#show" #, as: :gallery
  # post "/galleries" => "galleries#create"
  # get "/galleries/:id/edit" => "galleries#edit"
  # patch "/galleries/:id" => "galleries#update"
  # delete "/galleries/:id" => "galleries#destroy"


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
