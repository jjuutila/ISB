require "spec_helper"

describe SectionController do
  describe "routing" do
    it "recognizes and generates #news" do
      { :get => "/miehet-edustus/ajankohtaista" }.should route_to(:controller => "section",
        :section => "miehet-edustus", :action => "news")
    end
  end
end
