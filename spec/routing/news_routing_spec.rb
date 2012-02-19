require "spec_helper"

describe NewsController do
  it "recognizes and generates #index" do
    { :get => "/miehet-edustus/ajankohtaista" }.should route_to(:controller => "news",
      :section => "miehet-edustus", :action => "index")
  end
  
  it "recognizes and generates #show_news_post" do
    { :get => "/miehet-edustus/ajankohtaista/the-post-title" }.should route_to(:controller => "news",
      :section => "miehet-edustus", :slug => "the-post-title", :action => "show")
  end
end
