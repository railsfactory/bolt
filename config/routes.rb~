Rails.application.routes.draw do
  match "/admin" => redirect("/bolt")
  match "bolt/dashboard" => "bolt/dashboard#index"

  get "bolt/media/index"
  get "bolt/media/:id"  => "bolt/media#getfolderdatas", :as => "fetch_folder_data" 
  post "bolt/media/uploadFile"
  post "bolt/media/create_folder" => "bolt/media#create_folder", :as => "create_folder"  
  post "bolt/media/delete_folder" => "bolt/media#delete_folder", :as => "delete_folder"
  post "bolt/media/delete_file" => "bolt/media#delete_file", :as => "delete_file"
  get "/:cat_name/:id-:title" => "bolt/info#show", :as => :ambiguous_section, :defaults => {:id => nil, :cat_name => "Articles", :title => nil}
  get "/:id" => "bolt/info#show", :as => :page, :defaults => {:id => "Home", :cat => nil}
  root :to => "bolt/info#show"
  post "bolt/settings/:id" => "bolt/settings#update", :as => "update" 
  
  namespace :bolt do
		resources :banners
		resources :settings
    resources :page_sections
    resources :pages
    resources :articles_categories
    resources :user_statuses
    resources :statuses
    resources :accesses
    resources :categories
    resources :blogs
    resources :articles    
    resources :groups
    resources :users_groups
    resources :articles
    resources :media      

    resources :users do
      member do
        put :update_password, :reset_password
      end
    end
    
    resource :user_session
    resource :password_reset, :only => [:create, :edit, :update]
    
    match "/blank" => "bolt#blank"    
  end

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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
   match ':controller(/:action(/:id(.:format)))'
end
