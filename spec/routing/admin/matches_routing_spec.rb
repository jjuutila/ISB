require "spec_helper"

describe Admin::MatchesController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/admin/seasons/2/partitions/1/matches" }.should route_to(:controller => "admin/matches",
      :action => "index", :season_id => '2', :partition_id => '1')
    end

    it "recognizes and generates #new" do
      { :get => "/admin/seasons/2/partitions/1/matches/new" }.should route_to(:controller => "admin/matches",
      :action => "new", :season_id => '2', :partition_id => '1')
    end

    it "recognizes and generates #edit" do
      { :get => "/admin/seasons/2/partitions/1/matches/1/edit" }.should route_to(:controller => "admin/matches",
      :action => "edit", :season_id => '2', :partition_id => '1', :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/admin/seasons/2/partitions/1/matches" }.should route_to(:controller => "admin/matches",
      :season_id => '2', :partition_id => '1', :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/admin/seasons/2/partitions/1/matches/1" }.should route_to(:controller => "admin/matches",
      :action => "update", :season_id => '2', :partition_id => '1', :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/admin/seasons/2/partitions/1/matches/1" }.should route_to(:controller => "admin/matches",
        :action => "destroy", :season_id => '2', :partition_id => '1', :id => "1")
    end

  end
end
