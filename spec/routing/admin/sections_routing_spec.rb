require "spec_helper"

describe Admin::SectionsController do
  describe "routing" do

    it "recognizes and generates #edit_contact" do
      { :get => "/admin/sections/1/edit_contact" }.should route_to(:controller => "admin/sections",
        :action => "edit_contact", :id => '1')
    end
    
    it "recognizes and generates #update_contact" do
      { :put => "/admin/sections/1/update_contact" }.should route_to(:controller => "admin/sections", :action => "update_contact", :id => '1')
    end
  end
end
