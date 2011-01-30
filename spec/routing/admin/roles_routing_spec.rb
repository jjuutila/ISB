require "spec_helper"

describe Admin::RolesController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/admin/seasons/2/roles" }.should route_to(:controller => "admin/roles", :action => "index",
        :season_id => '2')
    end

    it "recognizes and generates #create" do
      { :post => "/admin/seasons/2/roles" }.should route_to(:controller => "admin/roles", :action => "create",
        :season_id => '2')
    end

    it "recognizes and generates #update" do
      { :put => "/admin/seasons/2/roles/1" }.should route_to(:controller => "admin/roles", :action => "update",
        :season_id => '2', :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/admin/seasons/2/roles/1" }.should route_to(:controller => "admin/roles", :action => "destroy",
        :season_id => '2', :id => "1")
    end

    it "recognizes and generates #current_team" do
      { :get => "/admin/current_team" }.should route_to(:controller => "admin/roles", :action => "current_team")
    end
    
  end
end
