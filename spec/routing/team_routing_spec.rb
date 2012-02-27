require "spec_helper"

describe TeamController do
  it "recognizes and generates #index" do
    { :get => "/miehet-edustus/joukkue" }.should route_to(:controller => "team",
      :section => "miehet-edustus", :action => "index")
  end
  
  it "recognizes and generates #show" do
    { :get => "/miehet-edustus/pelaaja/5" }.should route_to(:controller => "team",
      :section => "miehet-edustus", :id => "5", :action => "show")
  end
  
  it "does not route team with non-numeric id" do
    { :get => "/miehet-edustus/pelaaja/foo" }.should_not be_routable
  end
end
