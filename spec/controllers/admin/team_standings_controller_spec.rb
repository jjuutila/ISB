# coding: utf-8
require 'spec_helper'

describe Admin::TeamStandingsController do
  user_login
  
  def mock_team_standing(stubs={})
    (@mock_team_standing ||= mock_model(TeamStanding).as_null_object).tap do |team_standing|
      team_standing.stub(stubs) unless stubs.empty?
    end
  end
  
  before(:each) do
    @partition = mock_model(Partition)
    Partition.stub(:find).with(@partition.id) { @partition }
    @params = { 'these' => 'params' }
  end
  
  describe "GET new" do
    it "assigns a new team as @team" do
      TeamStanding.stub(:new).with(:partition_id => @partition.id) { mock_team_standing }
      get :new, :partition_id => @partition.id
      assigns(:team).should be(mock_team_standing)
    end
  end
  
  describe "POST create" do
    describe "with valid params" do
      before(:each) do
        @partition.stub_chain(:team_standings, :build).with(@params) { mock_team_standing(:save => true) }
      end
      
      it "assigns a newly created team as @team" do
        post :create, :partition_id => @partition.id, :team_standing => @params
        assigns(:team).should be(mock_team_standing)
      end
      
      it "redirects to the show partition page" do
        post :create, :partition_id => @partition.id, :team_standing => @params
        response.should redirect_to(admin_partition_path(@partition))
      end
      
      it "shows a flash message" do
        post :create, :partition_id => @partition.id, :team_standing => @params
        flash[:notice].should == 'Uusi joukkue luotu.'
      end
    end

    describe "with invalid params" do
      before(:each) do
        @partition.stub_chain(:team_standings, :build).with(@params) { mock_team_standing(:save => false, :errors => {:anything => "error"}) }
      end
      
      it "assigns a newly created but unsaved team as @team" do
        post :create, :partition_id => @partition.id, :team_standing => @params
        assigns(:team).should be(mock_team_standing)
      end

      it "re-renders the 'new' template" do
        post :create, :partition_id => @partition.id, :team_standing => @params
        response.should render_template("new")
      end
    end
  end
  
  describe "GET edit_multiple" do
    it "assigns the requested standings as @standings" do
      TeamStanding.should_receive(:where).with("partition_id = ?", @partition.id) { [mock_team_standing] }
      
      get :edit_multiple, :partition_id => @partition.id
      assigns(:standings).should == [mock_team_standing]
      assigns(:partition).should == @partition
    end
  end
  
  describe "POST update_multiple" do
    before(:each) do
      @params = { :partition_id => @partition.id, :standings => { 5 => {"these" => "params"} } }
    end
    
    describe "with valid params" do
      before(:each) do
        TeamStanding.stub(:update).with([5], [{"these" => "params", 'rank' => 1}]) { [mock_team_standing] }
      end
      
      it "redirects to partition" do
        put :update_multiple, @params
        response.should redirect_to admin_partition_path @partition
      end
      
      it "sets flash.notice" do
        put :update_multiple, @params
        flash.notice.should == "Sarjataulukko päivitetty."
      end
    end
    
    describe "with invalid params" do
      it "renders the edit_multiple view" do
        TeamStanding.stub(:update) { [mock_team_standing(:errors => {:anything => "error"})] }
        put :update_multiple, @params
        response.should render_template("edit_multiple")
      end
      
      it "assigns the edited stadings as @standings" do
        TeamStanding.stub(:update) { [mock_team_standing(:errors => {:anything => "error"})] }
        put :update_multiple, @params
        assigns(:standings).should == [mock_team_standing]
      end
      
      it "sets flash.notice" do
        TeamStanding.stub(:update) { [mock_team_standing(:errors => {:anything => "error"})] }
        put :update_multiple, @params
        flash.alert.should == "Sarjataulukko päivitetty vain osittain, koska joissain kentissä on virheitä."
      end
      
      it "redirects to edit_multiple view if one standing is not found from database" do
        TeamStanding.stub(:update).and_raise(ActiveRecord::RecordNotFound)
        put :update_multiple, @params
        response.should redirect_to edit_multiple_admin_partition_team_standings_path @partition
      end
      
      it "sets flash.notice if one standing is not found from database" do
        TeamStanding.stub(:update).and_raise(ActiveRecord::RecordNotFound)
        put :update_multiple, @params
        flash.alert.should == "Sarjataulukko päivitetty vain osittain, koska joitain tilastorivejä ei löytynyt tietokannasta."
      end
    end
  end
  
  describe "GET 'latest'" do
    before(:each) do
      @section = mock_model(Section)
      controller.stub(:selected_section) { @section }
      
      @partition.stub(:season) { @season }
    end
    
    it "redirects to the latest season's latest partition's team standings" do
      Partition.should_receive(:latest).with(@section) { @partition }
      
      get 'latest'
      response.should redirect_to edit_multiple_admin_partition_team_standings_path @partition
    end
    
    it "redirects to seasons if no partition is found" do
      Partition.should_receive(:latest).and_raise(ActiveRecord::RecordNotFound)
      
      get 'latest'
      response.should redirect_to admin_seasons_path
    end
  end

end
