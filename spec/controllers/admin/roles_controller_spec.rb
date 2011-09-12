require 'spec_helper'

describe Admin::RolesController do
  user_login

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
      Season.stub(:find).with("2") { mock_season }
    end
    
    it "assigns the requested season as @season" do
      get :index, :season_id => 2
      assigns(:season).should eq(mock_season)
    end
    
    it "assigns unassigned members as @unassigned_members" do
      Member.stub(:not_in_season).with(mock_season) { [mock_member] }
      get :index, :season_id => 2
      assigns(:unassigned_members).should eq([mock_member])
    end
    
    it "assigns all players as @players" do
      Member.stub_chain(:with_role, :in_season).with(mock_season) { [mock_member] }
      get :index, :season_id => 2
      assigns(:players).should eq([mock_member])
    end
    
    it "assigns all coaches as @coaches" do
      Member.stub_chain(:with_role, :in_season).with(mock_season) { [mock_member] }
      get :index, :season_id => 2
      assigns(:coaches).should eq([mock_member])
    end
  end
  
  describe "POST create" do
    before(:each) do
      Season.stub(:find).with("2") { mock_season }
      Member.stub(:find).with("1") { mock_member }
      @params = {"role" => "player"}
    end
    
    it "with valid params creates a new affair" do
      Affair.stub(:new).with(:season => mock_season, :member => mock_member, :role => 'player') {mock_affair}
      mock_affair.should_receive(:save).and_return(true)
      
      xhr :post, :create, {:season_id => 2, :id => 1, :data => @params, :format => 'js'}
      response.should be_success
    end
    
    it "with invalid params returns error" do
      Affair.stub(:new).with(:season => mock_season, :member => mock_member, :role => 'player') {
        mock_affair(:save => false, :errors => {:anything => "error"}) }
      
      xhr :post, :create, {:season_id => 2, :id => 1, :data => @params, :format => 'js'}
      response.should_not be_success
    end

  end
  
  describe "PUT update" do
    before(:each) do
      Season.stub(:find).with("2") { mock_season }
      Member.stub(:find).with("1") { mock_member }
      @params = {"these" => "params"}
    end
    
    describe "with valid params" do
      it "updates affair's role" do
        Affair.should_receive(:find_by_season_id_and_member_id!).with(mock_season.id, mock_member.id) {mock_affair}
        mock_affair.should_receive(:update_attributes).with(@params).and_return(true)
        xhr :put, :update, {:season_id => 2, :id => 1, :data => @params, :format => 'js'}
      end
      
      it "responds with success" do
        Affair.stub(:find_by_season_id_and_member_id!) {mock_affair(:update_attributes => true)}
        xhr :put, :update, {:season_id => 2, :id => 1, :data => @params, :format => 'js'}
        response.should be_success
      end
    end
    
    describe "with invalid params" do
      it "responds with error" do
        Affair.stub(:find_by_season_id_and_member_id!) {mock_affair(:update_attributes => false)}
        xhr :put, :update, {:season_id => 2, :id => 1, :data => @params, :format => 'js'}
        response.should_not be_success
      end
    end
  end
  
  describe "DELETE destroy" do
    before(:each) do
      Season.stub(:find).with("2") { mock_season }
      Member.stub(:find).with("1") { mock_member }
    end
    
    it "destroys the requested affair" do
      Affair.should_receive(:find_by_season_id_and_member_id!).with(mock_season.id, mock_member.id) {mock_affair}
      mock_affair.should_receive(:destroy)
      delete :destroy, :season_id => 2, :id => 1
    end

    it "returns true on successful delete" do
      Affair.stub(:find_by_season_id_and_member_id!) {mock_affair}
      delete :destroy, :season_id => 2, :id => 1
      response.should be_success
    end
  end
  
  describe "GET current_team" do
    it "redirects to latest season's roles" do
      mock_section = mock_model(Section)
      controller.should_receive(:selected_section).and_return(mock_section)
      Season.should_receive(:latest).with(mock_section) {mock_season}
      
      get 'current_team'
      response.should redirect_to admin_season_roles_path mock_season
    end
    
    it "redirects to seasons if no seasons has not been created" do
      controller.stub(:selected_section).and_return(mock_model(Section))
      Season.stub(:latest).and_raise(ActiveRecord::RecordNotFound)
      
      get 'current_team'
      response.should redirect_to admin_seasons_path
    end
  end
end
