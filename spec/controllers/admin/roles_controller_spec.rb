require 'spec_helper'

describe Admin::RolesController do

  def mock_affair(stubs={})
    @mock_affair ||= mock_model(Affair, stubs).as_null_object
  end
  
  def mock_member(stubs={})
    @mock_member ||= mock_model(Member, stubs).as_null_object
  end
  
  def mock_season(stubs={})
    @mock_season ||= mock_model(Season, stubs).as_null_object
  end

  describe "GET index" do
    before(:each) do
      Season.stub(:find).with(2) { mock_season }
    end
    
    it "assigns the requested season as @season do" do
      get :index, :season_id => 2
      assigns(:season).should eq(mock_season)
    end
    
    it "assigns unassigned members as @unassigned_members" do
      Member.stub(:not_in_season).with(mock_season) { [mock_member] }
      get :index, :season_id => 2
      assigns(:unassigned_members).should eq([mock_member])
    end
    
    it "assigns all players as @players" do
      Member.stub_chain(:players, :in_season).with(mock_season) { [mock_member] }
      get :index, :season_id => 2
      assigns(:players).should eq([mock_member])
    end

  end
  
  describe "POST create" do
    before(:each) do
      Season.stub(:find).with(2) { mock_season }
      Member.stub(:find).with(1) { mock_member }
    end
    
    it "with valid params creates a new affair" do
      Affair.stub(:new).with(:season => mock_season, :member => mock_member, :role => 'player') {
        mock_affair(:save => true) }
      
      xhr :post, :create, {:season_id => 2, :member_id => 1, :role => 'player', :format => 'js'}
      response.should be_success
    end
    
    it "with invalid params returns error" do
      Affair.stub(:new).with(:season => mock_season, :member => mock_member, :role => 'player') {
        mock_affair(:save => false, :errors => {:anything => "error"}) }
      
      xhr :post, :create, {:season_id => 2, :member_id => 1, :role => 'player', :format => 'js'}
      response.should_not be_success
    end

  end

end
