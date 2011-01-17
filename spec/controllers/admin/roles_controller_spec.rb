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
    
    it "assigns all members as @all_members" do
      Member.stub(:all) { [mock_member] }
      get :index, :season_id => 2
      assigns(:all_members).should eq([mock_member])
    end
    
    it "assigns all players as @players" do
      #Member.stub(:players { [mock_member] }
      get :index, :season_id => 2
    end
    
    it "assigns the requested season as @season do" do
      get :index, :season_id => 2
      assigns(:season).should eq(mock_season)
    end
  end

end
