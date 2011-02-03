require "spec_helper"

describe Admin::StatisticsController do
  describe "routing" do

    it "recognizes and generates #edit_multiple" do
      { :get => "/admin/partitions/1/statistics/edit_multiple" }.should route_to(:controller => "admin/statistics",
        :action => "edit_multiple", :partition_id => '1')
    end
    
    it "recognizes and generates #edit_multiple" do
      { :put => "/admin/partitions/1/statistics/update_multiple" }.should route_to(:controller => "admin/statistics",
        :action => "update_multiple", :partition_id => '1')
    end
  end
end
