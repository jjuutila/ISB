# coding: utf-8
require 'spec_helper'

describe Admin::NewsController do
  user_login
  
  def mock_news(stubs={})
    (@mock_news ||= mock_model(News).as_null_object).tap do |news|
      news.stub(stubs) unless stubs.empty?
    end
  end

  let(:mock_section) { mock_model(Section) }
  
  describe "GET index" do
    it "assigns news in selected section as @news" do
      controller.stub(:selected_section) {mock_section}
      News.should_receive(:in_section).with(mock_section, "2") {[mock_news]}
      get :index, :page => 2
      assigns(:news).should eq([mock_news])
    end
  end
  
  describe "GET show" do
    it "assigns the requested news posting as @news" do
      News.should_receive(:find).with("37") { mock_news }
      get :show, :id => "37"
      assigns(:news).should be(mock_news)
    end
  end
  
  describe "GET new" do
    before(:each) do
      controller.stub(:selected_section) {mock_section}
      Section.stub(:visible) { [mock_section] }
    end
    
    it "assigns a new news post as @news" do
      News.should_receive(:new).with(:sections => [mock_section]) { mock_news }
      get :new
      assigns(:news).should be(mock_news)
    end
    
    it "assigns available Sections as @sections" do
      News.stub(:new)
      get :new
      assigns(:sections).should == ([mock_section])
    end
  end
  
  describe "GET edit" do
    it "assigns the requested news as @news" do
      News.should_receive(:find).with("37") { mock_news }
      get :edit, :id => "37"
      assigns(:news).should be(mock_news)
    end
  end
  
  describe "POST create" do    
    describe "with valid params" do
      it "assigns a newly created news post as @news" do
        News.should_receive(:new).with('these' => 'params') { mock_news(:save => true) }
        post :create, :news => {'these' => 'params'}
        assigns(:news).should be(mock_news)
      end

      it "redirects to the created news post" do
        News.stub(:new) { mock_news(:save => true) }
        post :create, :news => {'these' => 'params'}
        response.should redirect_to admin_news_index_path
      end
      
      it "sets the flash.notice" do
        News.stub(:new) { mock_news(:save => true) }
        post :create, :news => {'these' => 'params'}
        flash[:notice].should == 'Uusi uutinen lisätty.'
      end
    end

    describe "with invalid params" do 
      it "assigns a newly created but unsaved news post as @news" do
        News.stub(:new) { mock_news(:save => false, :errors => {:any => "error"}) }
        post :create, :news => {'these' => 'params'}
        assigns(:news).should be(mock_news)
      end

      it "re-renders the 'new' template" do
        News.stub(:new) { mock_news(:save => false, :errors => {:any => "error"}) }
        post :create, :news => {'these' => 'params'}
        response.should render_template("new")
      end
    end
  end
  
  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested news post" do
        News.should_receive(:find).with("37") { mock_news }
        mock_news.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :news => {'these' => 'params'}
      end

      it "assigns the requested news post as @news" do
        News.stub(:find) { mock_news(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:news).should be(mock_news)
      end

      it "redirects to news index" do
        News.stub(:find) { mock_news(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to admin_news_index_url
      end
      
      it "sets the flash.notice" do
        News.stub(:find) { mock_news(:update_attributes => true) }
        put :update, :id => "1"
        flash[:notice].should == 'Uutinen päivitetty.'
      end
    end

    describe "with invalid params" do
      it "assigns the news post as @news" do
        News.stub(:find) { mock_news(:update_attributes => false, :errors => {:any => "error"}) }
        put :update, :id => "1"
        assigns(:news).should be(mock_news)
      end

      it "re-renders the 'edit' template" do
        News.stub(:find) { mock_news(:update_attributes => false, :errors => {:any => "error"}) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested news post" do
      News.should_receive(:find).with("37") { mock_news }
      mock_news.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the news list" do
      News.stub(:find) { mock_news }
      delete :destroy, :id => "1"
      response.should redirect_to admin_news_index_url
    end
  end
end