require "spec_helper"

describe Admin::SeasonsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/admin/seasons" }.should route_to(:controller => "admin/seasons", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/admin/seasons/new" }.should route_to(:controller => "admin/seasons", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/admin/seasons/1" }.should route_to(:controller => "admin/seasons", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/admin/seasons/1/edit" }.should route_to(:controller => "admin/seasons", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/admin/seasons" }.should route_to(:controller => "admin/seasons", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/admin/seasons/1" }.should route_to(:controller => "admin/seasons", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/admin/seasons/1" }.should route_to(:controller => "admin/seasons", :action => "destroy", :id => "1")
    end

  end
end
