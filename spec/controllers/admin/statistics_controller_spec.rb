# coding: utf-8
require 'spec_helper'

describe Admin::StatisticsController do

  def mock_statistic(stubs={})
    (@mock_statistic ||= mock_model(Statistic).as_null_object).tap do |statistic|
      statistic.stub(stubs) unless stubs.empty?
    end
  end
  
  before(:each) do
    @season = mock_model(Season)
    Season.stub(:find).with(@season.id) { @season }
    
    @partition = mock_model(Partition)
    Partition.stub(:find).with(@partition.id) { @partition }
  end
  
  describe "GET edit_multiple" do
    it "assigns the requested partitions statistics as @statistics" do
      Statistic.should_receive(:where).with("partition_id = ?", @partition.id) { [mock_statistic] }
      
      get :edit_multiple, :partition_id => @partition.id
      assigns(:statistics).should == [mock_statistic]
      assigns(:partition).should == @partition
    end
  end
  
  describe "POST update_multiple" do
    before(:each) do
      @params = {:partition_id => @partition.id, :statistics => {1 => :params}}
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
      
      @partition.stub(:season) { @season }
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

end
