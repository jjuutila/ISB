# coding: utf-8
require 'spec_helper'

describe SectionController do
  def mock_news(stubs={})
    (@mock_news ||= mock_model(News).as_null_object).tap do |news|
      news.stub(stubs) unless stubs.empty?
    end
  end
  
  def mock_partition(stubs={})
    (@mock_partition ||= mock_model(Partition).as_null_object).tap do |partition|
      partition.stub(stubs) unless stubs.empty?
    end
  end
  
  def mock_comment(stubs={})
    (@mock_comment ||= mock_model(Comment).as_null_object).tap do |comment|
      comment.stub(stubs) unless stubs.empty?
    end
  end
  
  def mock_member(stubs={})
    (@mock_member ||= mock_model(Member).as_null_object).tap do |member|
      member.stub(stubs) unless stubs.empty?
    end
  end
  
  def mock_season(stubs={})
    (@mock_season ||= mock_model(Season).as_null_object).tap do |season|
      season.stub(stubs) unless stubs.empty?
    end
  end

  find_section
  
  describe "'GET' news" do
    it "sets requested news posts as @news" do
      News.should_receive(:in_section).with(@section, 2) {[mock_news]}
      get :news, :section => 'edustus', :page => 2
      assigns(:news).should == [mock_news]
    end
  end
  
  describe "'GET' matches" do
    it "sets the latest partition in requested section as @partition" do
      Partition.should_receive(:latest).with(@section).and_return(mock_partition)
      
      mock_match = mock_model(Match)
      Match.stub(:where) {[mock_match]}
      
      get :matches, :section => 'edustus'
      assigns(:partition).should == mock_partition
    end
    
    it "sets matches from the newest partition in requested section as @matches" do
      Partition.stub(:latest) {mock_partition}
      
      mock_match = mock_model(Match)
      Match.should_receive(:where).with(:partition_id => mock_partition.id).and_return([mock_match])
      
      get :matches, :section => 'edustus'
      assigns(:matches).should == [mock_match]
    end
    
    it "sets empty array as @matches if no partition is found" do
      Partition.should_receive(:latest).and_raise(ActiveRecord::RecordNotFound)
      get :matches, :section => 'edustus'
      assigns(:matches).should == []
    end
  end
  
  describe "'GET' show_match" do
    it "sets the requested match as @match" do
      mock_match = mock_model(Match)
      Match.should_receive(:find).with(3).and_return(mock_match)
      get :show_match, :section => 'edustus', :id => 3
      assigns(:match).should == mock_match
    end
  end
  
  describe "'GET' guestbook" do
    it "sets the requested sections comments as @messages" do
      Comment.should_receive(:messages).with(@section, 2).and_return([mock_comment])
      get :guestbook, :section => 'edustus', :page => 2
      assigns(:messages).should == [mock_comment]
    end
  end
  
  describe "'GET' new_guestbook_message" do
    it "assigns a new comment as @message" do
      Comment.should_receive(:new).and_return(mock_comment)
      get :new_guestbook_message, :section => 'edustus'
      assigns(:message).should == mock_comment
    end
  end
  
  describe "'POST' create_guestbook_message" do
    before(:each) do
      @params = {'these' => 'params'}
    end
    
    describe "with valid params" do
      it "assigns a newly created comment as @message" do
        @section.stub_chain(:comments, :build).with(@params) { mock_comment(:save => true) }
        post :create_guestbook_message, :section => 'edustus', :comment => @params
        assigns(:message).should == mock_comment
      end
      
      it "redirects to guestbook page" do
        @section.stub_chain(:comments, :build).with(@params) { mock_comment(:save => true) }
        post :create_guestbook_message, :section => 'edustus', :comment => @params
        response.should redirect_to(guestbook_path(@section.slug))
      end
    end
    
    describe "with invalid params" do
      it "assigns a newly created but unsaved comment as @message" do
        @section.stub_chain(:comments, :build).with(@params) { mock_comment(:save => false,
          :errors => {"some" => "error"}) }
        post :create_guestbook_message, :section => 'edustus', :comment => @params
        assigns(:message).should == mock_comment
      end
      
      it "re-renders the new_guestbook_message page" do
        @section.stub_chain(:comments, :build).with(@params) { mock_comment(:save => false,
          :errors => {"some" => "error"}) }
        post :create_guestbook_message, :section => 'edustus', :comment => @params
        should_not respond_with(:redirect)
        response.should render_template("new_guestbook_message")
      end
    end
  end
  
  describe "'GET' links" do
    it "assigns requested section's all link categories as @link_categories" do
      mock_category = mock_model(LinkCategory)
      LinkCategory.should_receive(:in_section).with(@section).and_return([mock_category])
      get :links, :section => 'edustus'
      assigns(:link_categories).should == [mock_category]
    end
  end
  
  describe "'GET' statistics" do
    before(:each) do
      Partition.stub(:latest).with(@section) { mock_partition }
    end
    
    it "assigns the requested sections most recents statistics as @statistics" do
      mock_statistics = mock_model(Statistic)
      Statistic.should_receive(:in_partition).with(mock_partition).and_return([mock_statistics])
      get :statistics, :section => 'edustus'
      assigns(:statistics).should == [mock_statistics]
    end
    
    it "assigns the requested sections newest partition as @partition" do
      mock_statistics = mock_model(Statistic)
      Statistic.stub(:in_partition) {[mock_statistics]}
      get :statistics, :section => 'edustus'
      assigns(:partition).should == mock_partition
    end
    
    it "assigns an empty array as @statistics if requested section doesn't have any partitions" do
      Partition.should_receive(:latest).and_raise(ActiveRecord::RecordNotFound)
      get :statistics, :section => 'edustus'
      assigns(:statistics).should == []
    end
  end
  
  describe "'GET' team" do
    it "assigns requested section's most recent's season's players as @players" do
      Season.stub(:latest) {mock_season}
      Member.stub(:with_role_in_season).with("player", mock_season).and_return([mock_member])
      get :team, :section => 'edustus'
      assigns(:players).should == [mock_member]
    end
    
    it "assigns @players, @assistants and @coaches as an empty array if season is not found" do
      Season.should_receive(:latest).and_raise(ActiveRecord::RecordNotFound)
      get :team, :section => 'edustus'
      assigns(:coaches).should == []
      assigns(:players).should == []
      assigns(:assistants).should == []
    end
  end
  
  describe "'GET' standings" do
    it "assigns requested Section's latest partition as @partition" do
      Partition.stub(:latest).with(@section) { mock_partition }
      get :standings, :section => 'edustus'
      assigns(:partition).should == mock_partition
    end
    
    it "assigns nil as @partition if no partitions are found" do
      get :standings, :section => 'edustus'
      assigns(:partition).should == nil
    end
  end
  
  describe "'GET' player" do
    it "assigns requested member as @member" do
      mock_player = mock_model(Member)
      Member.should_receive(:find).with(3).and_return(mock_player)
      get :player, :section => 'edustus', :id => 3
      assigns(:member).should == mock_player
    end
  end
  
  describe "GET 'all_time_statistics'" do
    it "assigns members as @players that have 'player' role and have scored some points" do
      player = mock_model(Member)
      group = mock_model(SectionGroup)
      group.stub(:are_players_male) { true }
      @section.stub(:group) { group }
      Member.should_receive(:players_with_points_in_any_season).with(true).and_return([player])
      get :all_time_statistics, :section => 'edustus'
      assigns(:players).should == [player]
    end
  end
end