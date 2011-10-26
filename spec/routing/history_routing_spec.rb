require "spec_helper"

describe HistoryController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/miehet-edustus/historia" }.should route_to(:controller => "history",
        :section => "miehet-edustus", :action => "index")
    end
    
    it "recognizes and generates #show" do
      { :get => "/miehet-edustus/historia/2004" }.should route_to(:controller => "history",
        :section => "miehet-edustus", :year => "2004", :action => "show")
    end
    
    it "does not recognize a non-numeric year" do
      { :get => "/miehet-edustus/historia/foo" }.should_not be_routable
    end
    
    it "does not recognize a year that is not 4 numbers long" do
      { :get => "/miehet-edustus/historia/123" }.should_not be_routable
      { :get => "/miehet-edustus/historia/12345" }.should_not be_routable
    end
  end
end
