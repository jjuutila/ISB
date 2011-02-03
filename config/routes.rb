Isb::Application.routes.draw do
  # The priority is based upon order of creation:
  # first created -> highest priority.
  
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
    match "current_team" => "roles#current_team", :via => :get
    match 'latest_statistics' => "statistics#latest", :via => :get
    
    resources :news
    resources :sections
    resources :comments
    resources :members
    
    resources :seasons do
      resources :partitions, :except => :index
      resources :roles, :except => [:show, :new, :edit]
    end
    
    resources :partitions, :except => :index do
      resources :team_standings, :except => [:index, :show] do
       get 'edit_multiple', :on => :collection
       put 'update_multiple', :on => :collection
      end
      resources :statistics, :except => [:index, :show, :new, :update, :create, :destroy, :edit] do
        get 'edit_multiple', :on => :collection
        put 'update_multiple', :on => :collection
      end
      resources :matches, :except => [:show]
    end
    
    resources :link_categories do
      resources :links, :except => [:index, :show]
    end
  end
end
