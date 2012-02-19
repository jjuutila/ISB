require "spec_helper"

describe NewsController do
  it "recognizes and generates #index" do
    { :get => "/miehet-edustus/ajankohtaista" }.should route_to(:controller => "news",
      :section => "miehet-edustus", :action => "index")
  end
  
  it "recognizes and generates #show_news_post" do
    { :get => "/miehet-edustus/ajankohtaista/5" }.should route_to(:controller => "news",
      :section => "miehet-edustus", :id => "5", :action => "show")
  end
  
  it "does not route news post with non-numeric id" do
    { :get => "/miehet-edustus/ajankohtaista/foo" }.should_not be_routable
  end
end
