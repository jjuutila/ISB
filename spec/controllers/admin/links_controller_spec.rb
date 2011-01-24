# coding: utf-8
require 'spec_helper'

describe Admin::LinksController do

  def mock_link(stubs={})
    @mock_link ||= mock_model(Link, stubs).as_null_object
  end
  
  def mock_category(stubs={})
    @mock_category ||= mock_model(LinkCategory, stubs).as_null_object
  end
  
  before(:each) do
    LinkCategory.stub(:find).with(2) {mock_category}
  end

  describe "GET new" do
    it "assigns a new link as @link" do
      Link.stub(:new) { mock_link }
      get :new, :link_category_id => 2
      assigns(:link).should be(mock_link)
    end
    
    it "assigns the requested category as @category" do
      Link.stub(:new) { mock_link }
      get :new, :link_category_id => 2
      assigns(:category).should be(mock_category)
    end
  end

  describe "GET edit" do
    it "assigns the requested link as @link" do
      Link.stub(:find).with("37") { mock_link }
      get :edit, :link_category_id => 2, :id => "37"
      assigns(:link).should be(mock_link)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "assigns a newly created link as @link" do
        Link.stub(:new).with({'these' => 'params'}) { mock_link(:save => true) }
        post :create, :link_category_id => 2, :link => {'these' => 'params'}
        assigns(:link).should be(mock_link)
      end

      it "redirects to the created link" do
        Link.stub(:new) { mock_link(:save => true) }
        post :create, :link_category_id => 2, :link => {}
        response.should redirect_to(admin_link_category_path(mock_category))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved link as @link" do
        Link.stub(:new).with({'these' => 'params'}) { mock_link(:save => false) }
        post :create, :link_category_id => 2, :link => {'these' => 'params'}
        assigns(:link).should be(mock_link)
      end

      it "re-renders the 'new' template" do
        Link.stub(:new) { mock_link(:save => false) }
        post :create, :link_category_id => 2, :link => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested link" do
        Link.stub(:find).with("37") { mock_link }
        mock_link.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :link_category_id => 2, :id => "37", :link => {'these' => 'params'}
      end

      it "assigns the requested link as @link" do
        Link.stub(:find) { mock_link(:update_attributes => true) }
        put :update, :link_category_id => 2, :id => "1"
        assigns(:link).should be(mock_link)
      end

      it "redirects to the link" do
        Link.stub(:find) { mock_link(:update_attributes => true) }
        put :update, :link_category_id => 2, :id => "1"
        response.should redirect_to(admin_link_category_path(mock_category))
      end
    end

    describe "with invalid params" do
      it "assigns the link as @link" do
        Link.stub(:find) { mock_link(:update_attributes => false) }
        put :update, :link_category_id => 2, :id => "1"
        assigns(:link).should be(mock_link)
      end

      it "re-renders the 'edit' template" do
        Link.stub(:find) { mock_link(:update_attributes => false) }
        put :update, :link_category_id => 2, :id => "1"
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested link" do
      Link.stub(:find).with("37") { mock_link }
      mock_link.should_receive(:destroy)
      delete :destroy, :link_category_id => 2, :id => "37"
    end

    it "redirects to the links list" do
      Link.stub(:find) { mock_link }
      delete :destroy, :link_category_id => 2, :id => "1"
      response.should redirect_to(admin_link_category_path(mock_category))
    end
  end

end
