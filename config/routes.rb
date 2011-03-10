Isb::Application.routes.draw do
  # The priority is based upon order of creation:
  # first created -> highest priority.
  
  root :to => "home#index", :via => :get
  match "/uutiset/:id" => "home#show", :via => :get, :as => 'news'
  
  constraints(:section => /[a-z0-9-]+/) do
    match ':section/ajankohtaista' => 'section#news', :via => :get
    match ':section/ottelut' => 'section#matches', :via => :get, :as => 'matches'
    match ':section/ottelu/:id' => 'section#show_match', :via => :get, :as => 'match'
    match ':section/vieraskirja' => 'section#guestbook', :via => :get, :as => 'guestbook'
    match ':section/vieraskirja/kirjoita' => 'section#new_guestbook_message', :via => :get, :as => 'new_guestbook_message'
    match ':section/vieraskirja' => 'section#create_guestbook_message', :via => :post, :as => 'guestbook'
    match ':section/linkit' => 'section#links', :via => :get, :as => 'links'
    match ':section/pisteporssi' => 'section#statistics', :via => :get, :as => 'statistics'
    match ':section/joukkue' => 'section#team', :via => :get, :as => 'team'
    match ':section/sarjataulukko' => 'section#standings', :via => :get, :as => 'standings'
  end
  
  #scope(:name => "section", :path_names => { :new => "uusi", :edit => "muokkaa" }) do  
    #resources :news, :path => ":section/uutiset"
    #resources :seasons, :path => "kausi"
  #end
  
  namespace 'admin' do
    root :to => "News#index", :via => :get
    match "change_section" => "base#change_section"
    match "latest_standings" => "team_standings#latest", :via => :get
    match "current_team" => "roles#current_team", :via => :get
    match 'latest_statistics' => "statistics#latest", :via => :get
    
    resources :news
    resources :sections
    resources :comments, :except => [:new, :create, :show]
    resources :members, :except => [:delete, :show]
    
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
