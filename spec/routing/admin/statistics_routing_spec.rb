require "spec_helper"

describe Admin::StatisticsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/admin/statistics" }.should route_to(:controller => "admin/statistics", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/admin/statistics/new" }.should route_to(:controller => "admin/statistics", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/admin/statistics/1" }.should route_to(:controller => "admin/statistics", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/admin/statistics/1/edit" }.should route_to(:controller => "admin/statistics", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/admin/statistics" }.should route_to(:controller => "admin/statistics", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/admin/statistics/1" }.should route_to(:controller => "admin/statistics", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/admin/statistics/1" }.should route_to(:controller => "admin/statistics", :action => "destroy", :id => "1")
    end

  end
end
