Isb::Application.routes.draw do
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
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  
  #match ':section/:controller(/:action(/:id(.:format)))'
  
  match ':section/uutiset' => 'news#index', :constraints => { :section => /[a-z]\d{2,15}/ }
  match ':section/uutiset/:id' => 'news#show', :constraints => { :section => /[a-z]\d{2,15}/ }
  
  #scope(:name => "section", :path_names => { :new => "uusi", :edit => "muokkaa" }) do  
    #resources :news, :path => ":section/uutiset"
    #resources :seasons, :path => "kausi"
  #end
  
  namespace 'admin' do
    root :to => "News#index"
    match "change_section" => "base#change_section"
    match "latest_standings" => "team_standings#latest", :via => :get
    resources :news
    resources :sections
    resources :seasons do
      resources :partitions, :except => :index do
        resources :team_standings, :except => [:index, :show] do
         get 'edit_multiple', :on => :collection
         put 'update_multiple', :on => :collection
        end
        resources :statistics, :except => [:index, :show]
        resources :matches, :except => [:show]
      end
      resources :roles, :except => [:show, :new, :edit]
    end
    resources :comments
    resources :members
  end
end
