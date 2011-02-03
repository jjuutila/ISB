require "spec_helper"

describe Admin::TeamStandingsController do
  describe "routing" do
    it "recognizes and generates #new" do
      { :get => "/admin/partitions/1/team_standings/new" }.should route_to(:controller => "admin/team_standings",
        :partition_id => '1', :action => "new")
    end

    it "recognizes and generates #edit" do
      { :get => "/admin/partitions/1/team_standings/1/edit" }.should route_to(:controller => "admin/team_standings", :action => "edit",
        :partition_id => '1', :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/admin/partitions/1/team_standings" }.should route_to(:controller => "admin/team_standings", :action => "create",
        :partition_id => '1')
    end

    it "recognizes and generates #update" do
      { :put => "/admin/partitions/1/team_standings/1" }.should route_to(:controller => "admin/team_standings", :action => "update",
        :partition_id => '1', :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/admin/partitions/1/team_standings/1" }.should route_to(:controller => "admin/team_standings",
        :action => "destroy", :partition_id => '1', :id => "1")
    end
    
    it "recognizes and generates #latest_statistics" do
      { :get => "/admin/latest_standings" }.should route_to(:controller => "admin/team_standings",
        :action => "latest")
    end
    
    it "recognizes and generates #edit_multiple" do
      { :get => "/admin/partitions/1/team_standings/edit_multiple" }.should route_to(:controller => "admin/team_standings",
        :action => "edit_multiple", :partition_id => '1')
    end
    
    it "recognizes and generates #update_multiple" do
      { :put => "/admin/partitions/1/team_standings/update_multiple" }.should route_to(:controller => "admin/team_standings",
        :action => "update_multiple", :partition_id => '1')
    end
  end
end