require "spec_helper"

describe Admin::MatchesController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/admin/partitions/1/matches" }.should route_to(:controller => "admin/matches",
      :action => "index", :partition_id => '1')
    end

    it "recognizes and generates #new" do
      { :get => "/admin/partitions/1/matches/new" }.should route_to(:controller => "admin/matches",
      :action => "new", :partition_id => '1')
    end

    it "recognizes and generates #edit" do
      { :get => "/admin/partitions/1/matches/1/edit" }.should route_to(:controller => "admin/matches",
      :action => "edit", :partition_id => '1', :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/admin/partitions/1/matches" }.should route_to(:controller => "admin/matches",
      :partition_id => '1', :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/admin/partitions/1/matches/1" }.should route_to(:controller => "admin/matches",
      :action => "update", :partition_id => '1', :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/admin/partitions/1/matches/1" }.should route_to(:controller => "admin/matches",
        :action => "destroy", :partition_id => '1', :id => "1")
    end

  end
end
