require 'spec_helper'

describe Admin::TeamStandingsController do

  def mock_team_standing(stubs={})
    (@mock_team_standing ||= mock_model(TeamStanding).as_null_object).tap do |team_standing|
      team_standing.stub(stubs) unless stubs.empty?
    end
  end
  
  describe "GET edit_multiple" do
    it "assigns the requested standings as @standings" do
      section = Factory.create :section, :parent_id => 9999
      season = Season.create :start_year => 2010, :division => "1. divisioona", :section => section
      partition = Partition.create :name => 'Playoffs', :position => 2, :season => season
      TeamStanding.create :name => "a team", :partition => partition
      
      get :edit_multiple, :season_id => season.id, :partition_id => partition.id
      assigns(:standings).count.should == 1
      assigns(:season).should == season
      assigns(:partition).should == partition
    end
  end
  
  describe "GET 'latest'" do
    it "should redirect to the latest season's latest partition's team standings" do
      section = Factory.create :section, :parent_id => 9999
      latest_season = Season.create :start_year => 2010, :division => "1. divisioona", :section => section
      latest_partition = Partition.create :name => 'Playoffs', :position => 2, :season => latest_season
      
      get 'latest'
      response.should redirect_to(edit_multiple_admin_season_partition_team_standings_path(latest_season, latest_partition))
    end
  end
  
  describe "GET new" do
    it "assigns a new team as @team" do
      TeamStanding.stub(:new).with(:partition_id => '1') { mock_team_standing }
      get :new, :season_id => '2', :partition_id => '1'
      assigns(:team).should be(mock_team_standing)
    end
  end
  
  describe "POST create" do
    before(:each) do
        @season = mock_model(Season)
        Season.stub(:find).with(@season.id) { @season }
        
        @partition = mock_model(Partition)
        Partition.stub(:find).with(@partition.id) { @partition }
    end
    
    describe "with valid params" do
      before(:each) do
        TeamStanding.stub(:new).with({'partition' => @partition}) { mock_team_standing(:save => true) }
      end
      
      it "assigns a newly created team as @team" do
        post :create, :season_id => @season.id, :partition_id => @partition.id, :team_standing => {}
        assigns(:team).should be(mock_team_standing)
      end
      
      it "redirects to the show partition page" do
        post :create, :season_id => @season.id, :partition_id => @partition.id, :team_standing => {}
        response.should redirect_to(admin_season_partition_path(@season, @partition))
      end
      
      it "shows a flash message" do
        post :create, :season_id => @season.id, :partition_id => @partition.id, :team_standing => {}
        flash[:notice].should == 'Uusi joukkue luotu.'
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved team as @team" do
        TeamStanding.stub(:new) { mock_team_standing(:save => false) }
        post :create, :season_id => @season.id, :partition_id => @partition.id, :team_standing => {}
        assigns(:team).should be(mock_team_standing)
      end

      it "re-renders the 'new' template" do
        TeamStanding.stub(:new) { mock_team_standing(:save => false) }
        post :create, :season_id => @season.id, :partition_id => @partition.id, :team_standing => {}
        response.should render_template("new")
      end
    end

  end

end