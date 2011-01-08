require "spec_helper"

describe Admin::TeamStandingsController do
  describe "routing" do
    it "recognizes and generates #new" do
      { :get => "/admin/seasons/2/partitions/1/team_standings/new" }.should route_to(:controller => "admin/team_standings",
        :season_id => '2', :partition_id => '1', :action => "new")
    end

    it "recognizes and generates #edit" do
      { :get => "/admin/seasons/2/partitions/1/team_standings/1/edit" }.should route_to(:controller => "admin/team_standings", :action => "edit",
        :season_id => '2', :partition_id => '1', :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/admin/seasons/2/partitions/1/team_standings" }.should route_to(:controller => "admin/team_standings", :action => "create",
        :season_id => '2', :partition_id => '1')
    end

    it "recognizes and generates #update" do
      { :put => "/admin/seasons/2/partitions/1/team_standings/1" }.should route_to(:controller => "admin/team_standings", :action => "update",
        :season_id => '2', :partition_id => '1', :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/admin/seasons/2/partitions/1/team_standings/1" }.should route_to(:controller => "admin/team_standings",
        :action => "destroy", :season_id => '2', :partition_id => '1', :id => "1")
    end
    
    it "recognizes and generates #latest_statistics" do
      { :delete => "/admin/latest_standings" }.should route_to(:controller => "admin/team_standings",
        :action => "latest")
    end
  end
end