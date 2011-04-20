# coding: utf-8
require 'spec_helper'

describe Admin::LinkCategoriesController do
  user_login
  
  def mock_link_category(stubs={})
    @mock_link_category ||= mock_model(LinkCategory, stubs).as_null_object
  end
  
  def mock_section(stubs={})
    (@mock_section ||= mock_model(Section).as_null_object).tap do |section|
      section.stub(stubs) unless stubs.empty?
    end
  end

  describe "GET index" do
    it "assigns link_categories in selected section as @link_categories" do
      controller.stub(:selected_section) {mock_section}
      LinkCategory.should_receive(:in_section).with(mock_section).and_return([mock_link_category])
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
      controller.stub(:selected_section) {mock_section}
      LinkCategory.stub(:new) { mock_link_category }
      get :new
      assigns(:link_category).should be(mock_link_category)
    end
    
    it "assigns a the selected section as @selected_section" do
      controller.stub(:selected_section) {mock_section}
      LinkCategory.stub(:new) { mock_link_category }
      get :new
      assigns(:selected_section).should be(mock_section)
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
      before(:each) do
        controller.stub(:selected_section) {mock_section}
        mock_section.stub_chain(:link_categories, :build).with({'these' => 'params'}) { mock_link_category(:save => true) }
      end
      
      it "assigns a newly created link_category as @link_category" do
        post :create, :link_category => {'these' => 'params'}
        assigns(:link_category).should be(mock_link_category)
      end

      it "redirects to the created link_category" do
        post :create, :link_category => {'these' => 'params'}
        response.should redirect_to(admin_link_category_path(mock_link_category))
      end
      
      it "sets the flash.notice" do
        post :create, :link_category => {'these' => 'params'}
        flash[:notice].should == 'Uusi linkkikategoria luotu.'
      end
    end

    describe "with invalid params" do
      before(:each) do
        controller.stub(:selected_section) {mock_section}
        mock_section.stub_chain(:link_categories, :build).with({'these' => 'params'}) { mock_link_category(:save => false) }
      end
      
      it "assigns a newly created but unsaved link_category as @link_category" do
        post :create, :link_category => {'these' => 'params'}
        assigns(:link_category).should be(mock_link_category)
      end

      it "re-renders the 'new' template" do
        post :create, :link_category => {'these' => 'params'}
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
      
      it "sets the flash.notice" do
        LinkCategory.stub(:find) { mock_link_category(:update_attributes => true) }
        put :update, :id => "1"
        flash[:notice].should == 'Linkkikategoria päivitetty.'
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
