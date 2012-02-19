require "spec_helper"

describe SectionController do  
  describe "statistics routing" do
    it "recognizes and generates #latest_statistics" do
      { :get => "/miehet-edustus/pisteporssi" }.should route_to(:controller => "section",
        :section => "miehet-edustus", :action => "latest_statistics")
    end
    
    it "recognizes and generates #show_statistics" do
      { :get => "/miehet-edustus/pisteporssi/5" }.should route_to(:controller => "section",
        :section => "miehet-edustus", :id => "5", :action => "show_statistics")
    end
    
    it "does not route statistics with non-numeric id" do
      { :get => "/miehet-edustus/pisteporssi/foo" }.should_not be_routable
    end
    
    it "recognizes and generates #all_time_statistics" do
      { :get => "/miehet-edustus/pisteporssi/all-time" }.should route_to(:controller => "section",
        :section => "miehet-edustus", :action => "all_time_statistics")
    end
  end
  
  describe "standings routing" do
    it "recognizes and generates #latest_standings" do
      { :get => "/miehet-edustus/sarjataulukko" }.should route_to(:controller => "section",
        :section => "miehet-edustus", :action => "latest_standings")
    end
    
    it "recognizes and generates #show_standings" do
      { :get => "/miehet-edustus/sarjataulukko/5" }.should route_to(:controller => "section",
        :section => "miehet-edustus", :id => "5", :action => "show_standings")
    end
    
    it "does not route standings with non-numeric id" do
      { :get => "/miehet-edustus/sarjataulukko/foo" }.should_not be_routable
    end
  end
  
  describe "matches routing" do
    it "recognizes and generates #latest_matches" do
      { :get => "/miehet-edustus/ottelut" }.should route_to(:controller => "section",
        :section => "miehet-edustus", :action => "latest_matches")
    end
    
    it "recognizes and generates #show_matches" do
      { :get => "/miehet-edustus/ottelut/5" }.should route_to(:controller => "section",
        :section => "miehet-edustus", :id => "5", :action => "show_matches")
    end
    
    it "does not route to matches with non-numeric id" do
      { :get => "/miehet-edustus/ottelut/foo" }.should_not be_routable
    end
    
    it "recognizes and generates #show_match" do
      { :get => "/miehet-edustus/ottelu/5" }.should route_to(:controller => "section",
        :section => "miehet-edustus", :id => "5", :action => "show_match")
    end
    
    it "does not route to a match with non-numeric id" do
      { :get => "/miehet-edustus/ottelu/foo" }.should_not be_routable
    end
  end
  
  describe "guestbook routing" do
    it "recognizes and generates #guestbook" do
      { :get => "/miehet-edustus/vieraskirja" }.should route_to(:controller => "section",
        :section => "miehet-edustus", :action => "guestbook")
    end
    
    it "recognizes and generates #guestbook" do
      { :get => "/miehet-edustus/vieraskirja/kirjoita" }.should route_to(:controller => "section",
        :section => "miehet-edustus", :action => "new_guestbook_message")
    end
    
    it "recognizes and generates #guestbook" do
      { :post => "/miehet-edustus/vieraskirja" }.should route_to(:controller => "section",
        :section => "miehet-edustus", :action => "create_guestbook_message")
    end
  end
  
  describe "player routing" do
    it "recognizes and generates #player" do
      { :get => "/miehet-edustus/pelaaja/5" }.should route_to(:controller => "section",
        :section => "miehet-edustus", :id => "5", :action => "player")
    end
    
    it "does not recognize a non-numeric id" do
      { :get => "/miehet-edustus/pelaaja/foo" }.should_not be_routable
    end
  end
end
