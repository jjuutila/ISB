require "spec_helper"

describe PicasaController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/miehet-edustus/kuvagalleria" }.should route_to(:controller => "picasa",
        :section => "miehet-edustus", :action => "index")
    end
    
    it "recognizes and generates #show_album" do
      { :get => "/miehet-edustus/kuvagalleria/Foo123" }.should route_to(:controller => "picasa",
        :section => "miehet-edustus", :id => "Foo123", :action => "show_album")
    end
    
    it "recognizes and generates #show_photo" do
      { :get => "/miehet-edustus/kuvagalleria/Foo/51" }.should route_to(:controller => "picasa",
        :section => "miehet-edustus", :album_id => "Foo", :id => '51', :action => "show_photo")
    end
    
    it "does not recognize a non-numeric id" do
      { :get => "/miehet-edustus/kuvagalleria/Foo/bar" }.should_not be_routable
    end
  end
end
