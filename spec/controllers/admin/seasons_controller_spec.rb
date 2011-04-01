require 'spec_helper'

describe Admin::SeasonsController do
  def mock_season(stubs={})
    (@mock_season ||= mock_model(Season).as_null_object).tap do |season|
      season.stub(stubs) unless stubs.empty?
    end
  end
  
  def mock_section(stubs={})
    (@mock_section ||= mock_model(Section).as_null_object).tap do |section|
      section.stub(stubs) unless stubs.empty?
    end
  end
  
  
  describe "GET 'index'" do
    it "assigns all selected section's seasons as @seasons" do
      controller.stub(:selected_section) {mock_section}
      Season.stub(:in_section).with(mock_section).and_return([mock_season])
      get :index
      assigns(:seasons).should eq([mock_season])
    end
  end
  
  describe "GET show" do
    it "assigns the requested season as @season" do
      Season.stub(:find).with("37") { mock_season }
      get :show, :id => "37"
      assigns(:season).should be(mock_season)
    end
  end
  
  describe "GET 'new'" do
    it "assigns the new season as @season" do
      controller.stub(:selected_section) {mock_section}
      partition = mock_model(Partition)
      Partition.stub(:new) {partition}
      Season.stub(:new).with(:section_id => mock_section.id, :partitions => [partition]) { mock_season }
      get 'new'
      assigns(:season).should == mock_season
      response.should be_success
    end
  end
  
  describe "POST 'create'" do
    before(:each) do
      @params = {'these' => 'params'}
    end
    
    describe "with valid params" do
      it "should redirect to season page after successfull create." do
        Season.stub(:new).with(@params) { mock_season(:save => true) }
        post :create, :season => @params
        response.should redirect_to admin_season_path(mock_season)
      end
    end

    describe "with invalid params" do
      it "re-renders the 'new' template." do
        Season.should_receive(:new).with(@params) { mock_season(:save => false, :errors => {:any => "error"}) }
        post :create, :season => @params
        response.should render_template("new")
      end
    end
  end
  
  describe "GET 'edit'" do        
    it "assigns the requested season as @season" do
      controller.stub(:selected_section) { mock_section }
      Season.stub(:find).with(2) { mock_season }
      get 'edit', :id => 2
      assigns(:season).should == mock_season
      response.should be_success
    end
  end
  
  describe "PUT 'update'" do
    before(:each) do      
      @params = {'these' => 'params'}
    end
    
    describe "with valid params" do
      it "redirects to season page after successfull update." do
        Season.stub(:find).with(2) { mock_season(:update_attributes => true) }
        put :update, :season => @params, :id => 2
        response.should redirect_to admin_season_path(mock_season)
      end
    end

    describe "with invalid params" do
      it "re-renders the 'edit' template." do
        Season.stub(:find).with(3) { mock_season(:update_attributes => false,
          :errors => {:anything => "error"}) }
        put :update, {:season => @params, :id => 3 }
        response.should render_template("edit")
      end
    end
  end
end