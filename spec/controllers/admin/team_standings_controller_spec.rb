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

end