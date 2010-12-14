require "spec_helper"

describe Admin::StatisticsController do
  describe "routing" do
    
    it "recognizes and generates #new" do
      { :get => "/admin/seasons/2/partitions/1/statistics/new" }.should route_to(:controller => "admin/statistics",
        :season_id => '2', :partition_id => '1', :action => "new")
    end

    it "recognizes and generates #edit" do
      { :get => "/admin/seasons/2/partitions/1/statistics/1/edit" }.should route_to(:controller => "admin/statistics", :action => "edit",
        :season_id => '2', :partition_id => '1', :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/admin/seasons/2/partitions/1/statistics" }.should route_to(:controller => "admin/statistics", :action => "create",
        :season_id => '2', :partition_id => '1')
    end

    it "recognizes and generates #update" do
      { :put => "/admin/seasons/2/partitions/1/statistics/1" }.should route_to(:controller => "admin/statistics", :action => "update",
        :season_id => '2', :partition_id => '1', :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/admin/seasons/2/partitions/1/statistics/1" }.should route_to(:controller => "admin/statistics",
        :action => "destroy", :season_id => '2', :partition_id => '1', :id => "1")
    end

  end
end
