# coding: utf-8
require 'spec_helper'

describe Admin::LinkCategoriesController do

  def mock_link_category(stubs={})
    @mock_link_category ||= mock_model(LinkCategory, stubs).as_null_object
  end

  describe "GET index" do
    it "assigns all link_categories as @link_categories" do
      LinkCategory.stub(:all) { [mock_link_category] }
      get :index
      assigns(:link_categories).should eq([mock_link_category])
    end
  end

  describe "GET show" do
    it "assigns the requested link_category as @link_category" do
      LinkCategory.stub(:find).with("37") { mock_link_category }
      get :show, :id => "37"
      assigns(:link_category).should be(mock_link_category)
    end
  end

  describe "GET new" do
    it "assigns a new link_category as @link_category" do
      LinkCategory.stub(:new) { mock_link_category }
      get :new
      assigns(:link_category).should be(mock_link_category)
    end
  end

  describe "GET edit" do
    it "assigns the requested link_category as @link_category" do
      LinkCategory.stub(:find).with("37") { mock_link_category }
      get :edit, :id => "37"
      assigns(:link_category).should be(mock_link_category)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "assigns a newly created link_category as @link_category" do
        LinkCategory.stub(:new).with({'these' => 'params'}) { mock_link_category(:save => true) }
        post :create, :link_category => {'these' => 'params'}
        assigns(:link_category).should be(mock_link_category)
      end

      it "redirects to the created link_category" do
        LinkCategory.stub(:new) { mock_link_category(:save => true) }
        post :create, :link_category => {}
        response.should redirect_to(admin_link_category_path(mock_link_category))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved link_category as @link_category" do
        LinkCategory.stub(:new).with({'these' => 'params'}) { mock_link_category(:save => false) }
        post :create, :link_category => {'these' => 'params'}
        assigns(:link_category).should be(mock_link_category)
      end

      it "re-renders the 'new' template" do
        LinkCategory.stub(:new) { mock_link_category(:save => false) }
        post :create, :link_category => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested link_category" do
        LinkCategory.stub(:find).with("37") { mock_link_category }
        mock_link_category.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :link_category => {'these' => 'params'}
      end

      it "assigns the requested link_category as @link_category" do
        LinkCategory.stub(:find) { mock_link_category(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:link_category).should be(mock_link_category)
      end

      it "redirects to the link_category" do
        LinkCategory.stub(:find) { mock_link_category(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(admin_link_category_path(mock_link_category))
      end
    end

    describe "with invalid params" do
      it "assigns the link_category as @link_category" do
        LinkCategory.stub(:find) { mock_link_category(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:link_category).should be(mock_link_category)
      end

      it "re-renders the 'edit' template" do
        LinkCategory.stub(:find) { mock_link_category(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested link_category" do
      LinkCategory.stub(:find).with("37") { mock_link_category }
      mock_link_category.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the link_categories list" do
      LinkCategory.stub(:find) { mock_link_category }
      delete :destroy, :id => "1"
      response.should redirect_to(admin_link_categories_path)
    end
  end

end
