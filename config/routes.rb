Assessor::Application.routes.draw do
  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'home#index'

  get "home/index"
  get "people" => "home#people"
  get "about" => "home#about"

  get "score/index"

  get "course" => "course#index"

  resources :exercises

  get "khan-exercises/exercises/khan-site.html" => "exercises#khan_site"
  get "khan-exercises/exercises/khan-exercise.html" => "exercises#khan_exercise"

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

  # After user authenticates with provider, user needs to go to omniauth call
  # match '/auth/:provider/callback' => 'authentications#create'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  match '/api/v1/user/exercises/:exercise/problems/:problem/attempt' => 'score#attempt',
    :constraints => { :problem => /\d+/ }, :via => :post

  match '/api/v1/user/exercises/:exercise/problems/:problem/hint' => 'score#hint',
    :constraints => { :problem => /\d+/ }, :via => :post

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end