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
    describe "with valid params" do
      it "creates a new affair" do
        Season.stub(:find).with(2) { mock_season }
        Member.stub(:find).with(1) { mock_member }
        Affair.stub(:create).with(:season => mock_season, :member => mock_member, :role => 'player') {
          mock_affair(:save => true) }
        
        post :create, :season_id => 2, :id => 1, :role => 'player'
        xhr :post, :create, {:season_id => 2, :id => 1, :role => 'player', :format => 'js'}
        puts response.inspect
        response.should be_success
      end
    end

  end

end
