require "spec_helper"

describe Admin::LinksController do
  describe "routing" do
    it "recognizes and generates #new" do
      { :get => "/admin/link_categories/2/links/new" }.should route_to(:controller => "admin/links", :action => "new",
      :link_category_id => "2")
    end

    it "recognizes and generates #edit" do
      { :get => "/admin/link_categories/2/links/1/edit" }.should route_to(:controller => "admin/links", :action => "edit",
      :link_category_id => "2", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/admin/link_categories/2/links" }.should route_to(:controller => "admin/links", :action => "create",
      :link_category_id => "2")
    end

    it "recognizes and generates #update" do
      { :put => "/admin/link_categories/2/links/1" }.should route_to(:controller => "admin/links", :action => "update",
      :link_category_id => "2", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/admin/link_categories/2/links/1" }.should route_to(:controller => "admin/links", :action => "destroy",
      :link_category_id => "2", :id => "1")
    end

  end
end
