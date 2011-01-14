require 'spec_helper'

describe Admin::SeasonsController do
  def mock_season(stubs={})
    (@mock_season ||= mock_model(Season).as_null_object).tap do |season|
      season.stub(stubs) unless stubs.empty?
    end
  end
  
  def create_sections
    root_level_section = Factory.create(:section)
    @section = Factory.create(:section, :parent => root_level_section)
  end
  
  before(:each) do
    create_sections  
  end
  
  describe "GET 'index'" do
    it "should be successful" do
      create_sections
      get 'index'
      response.should be_success
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
    it "should be successful" do
      get 'new'
      assigns(:season).new_record?.should == true
      response.should be_success
    end
  end
  
  describe "POST 'create'" do
    before(:each) do
      @attributes = {:division => "3. Divisioona", :start_year => 2003, :section_id => @section.id.to_s,
        :partitions_attributes => {0 => {:name => 'Runkosarja'} } }  
    end
    
    it "should redirect to index page after successfull create." do
      post :create, :season => @attributes
      
      assigns(:season).errors.size.should == 0
      assigns(:season).new_record?.should == false
      response.should redirect_to admin_seasons_path
    end
  end
  
  describe "GET 'edit'" do    
    before(:each) do
      @season = Factory(:season, :section => @section)  
    end
        
    it "should be successful" do
      get 'edit', :id => @season.id.to_s 
      assigns(:season).id.should == @season.id
      response.should be_success
    end
  end
  
  describe "PUT 'update'" do
    before(:each) do      
      @season = Factory(:season, :section => @section)
      @attributes = {:division => "3. Divisioona", :start_year => 2003, :section_id => @section.id.to_s}
    end
    
    it "should redirect to index page after successfull update." do
      put :update, {:season => @attributes, :id => @season.id.to_s }
      
      assigns(:season).errors.size.should == 0
      response.should redirect_to admin_seasons_path
    end
    
    it "should render edit page if errors in member." do
      @attributes[:start_year] = 5
      put :update, {:season => @attributes, :id => @season.id.to_s }
        
      assigns(:season).errors.size.should > 0
      response.should be_success
      response.should render_template("edit")
    end
  end
end