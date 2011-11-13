Isb::Application.routes.draw do
  # The priority is based upon order of creation:
  # first created -> highest priority.
  
  root :to => "home#index", :via => :get
  match "/uutiset/:id" => "home#show", :via => :get, :as => 'news_post'
  
  devise_for :users, :controllers => { :confirmations => "admin/confirmations" }, :path => 'admin/users'
  # Devise default root for redirection after sign in
  match "/admin/news" => "admin/news#index", :via => :get, :as => 'user_root'  
  
  namespace 'admin' do
    # Devise custom confirmation
    as :user do
      put "users/confirmation/confirm", :to => "confirmations#confirm"
    end
    
    root :to => redirect("/admin/news"), :via => :get
    match "change_section" => "base#change_section", :via => :put, :as => 'change_section'
    match "latest_standings" => "team_standings#latest", :via => :get
    match "current_team" => "roles#current_team", :via => :get
    match 'latest_statistics' => "statistics#latest", :via => :get
    match 'latest_matches' => "matches#latest", :via => :get
    match 'latest_all_time' => "statistics#latest_all_time", :via => :get
    
    resources :news
    resources :sections, :except => [:destroy] do
      get 'edit_contact', :on => :member
      put 'update_contact', :on => :member
    end
    
    resources :comments, :except => [:new, :create, :show]
    resources :members, :except => [:destroy, :show]
    resources :sponsors, :except => [:show] do
      put :positions, :on => :collection
    end
    
    resources :seasons do
      resources :partitions, :except => :index
      resources :roles, :except => [:show, :new, :edit]
      
      get 'alltime_statistics', :on => :member, :controller => :statistics, :action => :edit_all_time_statistics
      put 'alltime_statistics', :on => :member, :controller => :statistics, :action => :update_all_time_statistics
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
  
  constraints(:section => /[a-z0-9-]+/, :id => /\d+/) do
    match ':section/ajankohtaista' => 'section#news', :via => :get, :as => "section_news"
    match ':section/ajankohtaista/:id' => 'section#show_news_post', :via => :get, :as => 'show_news_post'
    match ':section/ottelut' => 'section#latest_matches', :via => :get, :as => 'latest_matches'
    match ':section/ottelut/:id' => 'section#show_matches', :via => :get, :as => 'show_matches'
    match ':section/ottelu/:id' => 'section#show_match', :via => :get, :as => 'match'
    match ':section/vieraskirja' => 'section#guestbook', :via => :get, :as => 'guestbook'
    match ':section/vieraskirja/kirjoita' => 'section#new_guestbook_message', :via => :get, :as => 'new_guestbook_message'
    match ':section/vieraskirja' => 'section#create_guestbook_message', :via => :post, :as => 'guestbook'
    match ':section/linkit' => 'section#links', :via => :get, :as => 'links'
    match ':section/pisteporssi' => 'section#latest_statistics', :via => :get, :as => 'latest_statistics'
    match ':section/pisteporssi/:id' => 'section#show_statistics', :via => :get, :as => 'show_statistics'
    match ':section/pisteporssi/all-time' => 'section#all_time_statistics', :via => :get, :as => 'all_time_statistics'
    match ':section/joukkue' => 'section#team', :via => :get, :as => 'team'
    match ':section/sarjataulukko' => 'section#latest_standings', :via => :get, :as => 'latest_standings'
    match ':section/sarjataulukko/:id' => 'section#show_standings', :via => :get, :as => 'show_standings'
    match ':section/yhteystiedot' => 'section#contact_info', :via => :get, :as => 'contact_info'
    match ':section/pelaaja/:id' => 'section#player', :via => :get, :as => 'player'
    match ':section/kuvagalleria' => 'picasa#index', :via => :get, :as => 'albums'
    match ':section/kuvagalleria/:id' => 'picasa#show_album', :via => :get, :as => 'album', :constraints => { :id => /[A-Za-z0-9-]+/ }
    match ':section/kuvagalleria/:album_id/:id' => 'picasa#show_photo', :via => :get, :as => 'photo', :constraints => { :album_id => /[A-Za-z0-9-]+/ }
    match ':section' => redirect("/%{section}/ajankohtaista"), :via => :get
    match ':section/historia' => 'history#index', :via => :get, :as => 'history'
    match ':section/historia/:year' => 'history#show', :via => :get, :as => 'history_show', :constraints => { :year => /\d{4}/ }
  end
end
