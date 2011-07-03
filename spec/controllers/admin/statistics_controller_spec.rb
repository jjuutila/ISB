# coding: utf-8
require 'spec_helper'

describe Admin::StatisticsController do
  user_login

  def mock_statistic(stubs={})
    (@mock_statistic ||= mock_model(Statistic).as_null_object).tap do |statistic|
      statistic.stub(stubs) unless stubs.empty?
    end
  end
  
  def mock_member(stubs={})
    (@mock_member ||= mock_model(Member).as_null_object).tap do |member|
      member.stub(stubs) unless stubs.empty?
    end
  end
  
  before(:each) do
    @partition = mock_model(Partition)
    Partition.stub(:find).with(3) { @partition }
  end
  
  describe "GET edit_multiple" do
    it "assigns the requested partitions statistics as @statistics" do
      Statistic.should_receive(:in_partition).with(@partition) { [mock_statistic] }
      
      get :edit_multiple, :partition_id => 3
      assigns(:statistics).should == [mock_statistic]
      assigns(:partition).should == @partition
    end
  end
  
  describe "POST update_multiple" do
    before(:each) do
      @params = {:partition_id => 3, :statistics => {1 => :params}}
    end
    
    describe "with valid params" do
      it "updates statistics" do
        Statistic.should_receive(:update).with([1], [:params]) { [mock_statistic] }
        put :update_multiple, @params
      end
      
      it "redirects to partition" do
        Statistic.stub(:update) { [mock_statistic] }
        put :update_multiple, @params
        response.should redirect_to admin_partition_path @partition
      end
      
      it "sets flash.notice" do
        Statistic.stub(:update) { [mock_statistic] }
        put :update_multiple, @params
        flash.notice.should == "Pistepörssi päivitetty."
      end
    end
    
    describe "with invalid params" do
      it "renders the edit_multiple view" do
        Statistic.stub(:update) { [mock_statistic(:errors => {:anything => "error"})] }
        put :update_multiple, @params
        response.should render_template("edit_multiple")
      end
      
      it "assigns the edited statistics as @statistics" do
        Statistic.stub(:update) { [mock_statistic(:errors => {:anything => "error"})] }
        put :update_multiple, @params
        assigns(:statistics).should == [mock_statistic]
      end
      
      it "sets flash.notice" do
        Statistic.stub(:update) { [mock_statistic(:errors => {:anything => "error"})] }
        put :update_multiple, @params
        flash.alert.should == "Pistepörssi päivitetty vain osittain, koska joissain kentissä on virheitä."
      end
      
      it "redirects to edit_multiple view if any of the statistic is not found from database" do
        Statistic.stub(:update).and_raise(ActiveRecord::RecordNotFound)
        put :update_multiple, @params
        response.should redirect_to edit_multiple_admin_partition_statistics_path @partition
      end
      
      it "sets flash.notice if any of the statistic is not found from database" do
        Statistic.stub(:update).and_raise(ActiveRecord::RecordNotFound)
        put :update_multiple, @params
        flash.alert.should == "Pistepörssi päivitetty vain osittain, koska joitain tilastoja ei löytynyt enää tietokannasta."
      end
    end
  end
  
  describe "GET 'latest'" do
    before(:each) do
      @section = mock_model(Section)
      controller.stub(:selected_section) { @section }
    end
    
    it "redirects to the latest season's latest partition's statistics" do
      Partition.should_receive(:latest).with(@section) { @partition }
      
      get 'latest'
      response.should redirect_to edit_multiple_admin_partition_statistics_path @partition
    end
    
    it "redirects to seasons if no partition is found" do
      Partition.should_receive(:latest).and_raise(ActiveRecord::RecordNotFound)
      
      get 'latest'
      response.should redirect_to admin_seasons_path
    end
  end


  describe "GET 'edit_all_time_statistics'" do
    before(:each) do
      @section = mock_model(Section)
      controller.stub(:selected_section) { @section }
      
      @season = mock_model(Season)
      Season.stub(:find).with(5) { @season }

      Member.stub(:all_time_players_for_season).with(@season) {[mock_member]}
    end
    
    it "assigns requested season as @season" do
      get :edit_all_time_statistics, :id => 5
      assigns(:season).should == @season
    end
    
    it "assigns players in requested season as @player" do
      get :edit_all_time_statistics, :id => 5
      assigns(:players).should == [mock_member]
    end
  end
  
  describe "POST 'update_all_time_statistics'" do
    before(:each) do
      @params = { :id => 5, :all_time_statistics => {1 => :params} }
      
      @season = mock_model(Season)
      Season.stub(:find).with(5) { @season }
    end
    
    describe "with valid params" do
      before(:each) do
        Member.stub(:update) { [mock_member] }
      end
      
      it "updates all time statistics" do
        Member.should_receive(:update).with([1], [:params]) { [mock_member] }
        put :update_all_time_statistics, @params
      end
      
      it "redirects to season" do
        put :update_all_time_statistics, @params
        response.should redirect_to admin_season_path @season
      end
      
      it "sets flash.notice" do
        put :update_all_time_statistics, @params
        flash.notice.should == "All-Time pistepörssi päivitetty."
      end
      
      it "assigns requested season as @season" do
        put :update_all_time_statistics, @params
        assigns(:season).should == @season
      end
    end
    
    describe "with invalid params" do
      before(:each) do
        Member.stub(:update) { [mock_member(:errors => {:anything => "error"})] }
        
        @section = mock_model(Section)
        controller.stub(:selected_section) { @section }
      end
      
      it "renders the edit_all_time_statistics view" do
        put :update_all_time_statistics, @params
        response.should render_template(:edit_all_time_statistics)
      end
      
      it "assigns the edited players as @players" do
        put :update_all_time_statistics, @params
        assigns(:players).should == [mock_member]
      end
      
      it "sets flash.notice" do
        put :update_all_time_statistics, @params
        flash.alert.should == "All-Time pistepörssi päivitettiin vain osittain, koska joissain kentissä on virheitä."
      end
      
      it "redirects to edit_all_time_statistics if any of the members is not found" do
        Member.stub(:update).and_raise(ActiveRecord::RecordNotFound)
        put :update_all_time_statistics, @params
        response.should redirect_to alltime_statistics_admin_season_path @season
      end
      
      it "sets flash.notice if any of the statistic is not found" do
        Member.stub(:update).and_raise(ActiveRecord::RecordNotFound)
        put :update_all_time_statistics, @params
        flash.alert.should == "All-Time pistepörssi päivitettiin vain osittain, koska joitain pelaajia ei löytynyt tietokannasta."
      end
    end
  end
  
  describe "GET 'latest_all_time'" do
    before(:each) do
      @season = mock_model(Season)
      @section = mock_model(Section)
      controller.stub(:selected_section) { @section }
    end
    
    it "redirects to the latest season all-time statistics" do
      Season.should_receive(:latest).with(@section) { @season }
      
      get 'latest_all_time'
      response.should redirect_to alltime_statistics_admin_season_path @season
    end
    
    it "redirects to seasons if no partition is found" do
      Season.should_receive(:latest).and_raise(ActiveRecord::RecordNotFound)
      
      get 'latest_all_time'
      response.should redirect_to admin_seasons_path
    end
  end
end
