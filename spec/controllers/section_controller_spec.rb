# coding: utf-8
require 'spec_helper'

describe SectionController do
  def mock_partition(stubs={})
    (@mock_partition ||= mock_model(Partition).as_null_object).tap do |partition|
      partition.stub(stubs) unless stubs.empty?
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

  create_section
  
  describe "'GET' news" do
    it "sets requested news posts as @news" do
      news = Factory.create :news, :sections => [@section]
      get :news, :section => 'edustus', :page => 1
      assigns(:news).should == [news]
    end
  end
  
  describe "'GET' show_news_post" do
    it "sets the requested news post as @news" do
      news = Factory.create :news, :sections => [@section]
      get :show_news_post, :section => 'edustus', :id => news.id 
      assigns(:news).should == news
    end
  end
  
  describe "'GET' latest_matches" do
    it "sets the latest partition in requested section as @partition" do
      Partition.should_receive(:latest).with(@section).and_return(mock_partition)
      get :latest_matches, :section => 'edustus'
      assigns(:partition).should == mock_partition
    end
  end
  
  describe "'GET' show_matches" do
    it "assigns requested Partitions as @partition" do
      Partition.stub(:find).with("3") { mock_partition }
      get :show_matches, :section => 'edustus', :id => "3"
      assigns(:partition).should == mock_partition
    end
  end
  
  describe "'GET' show_match" do
    it "sets the requested match as @match" do
      mock_match = mock_model(Match)
      Match.should_receive(:find).with("3").and_return(mock_match)
      get :show_match, :section => 'edustus', :id => 3
      assigns(:match).should == mock_match
    end
  end
  
  describe "'GET' guestbook" do
    it "sets the requested section's comments as @messages" do
      message = Factory.build :comment
      message.assign_attributes({:commentable_id => @section.id, :commentable => @section},
        :without_protection => true)
      message.save!
      get :guestbook, :section => 'edustus', :page => 1
      assigns(:messages).should == [message]
    end
  end
  
  describe "'GET' new_guestbook_message" do
    it "assigns a new comment as @message" do
      get :new_guestbook_message, :section => 'edustus'
      assigns(:message).should be_a_new Comment
    end
  end
  
  describe "'POST' create_guestbook_message" do
    describe "with valid params" do
      before(:each) do
        @params = {'author' => 'name', :title => 'a title', :content => 'some content'}
      end
      
      it "redirects to guestbook page" do
        post :create_guestbook_message, :section => 'edustus', :comment => @params
        response.should redirect_to(guestbook_path(@section.slug))
      end
    end
    
    describe "with invalid params" do
      before(:each) do
        @params = {'these' => 'params'}
      end
      
      it "assigns an unsaved comment as @message" do
        post :create_guestbook_message, :section => 'edustus', :comment => @params
        assigns(:message).should be_a_new Comment
      end
      
      it "re-renders the new_guestbook_message template" do
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
  
  describe "'GET' latest_statistics" do
    before(:each) do
      Partition.stub(:latest).with(@section) { mock_partition }
    end
    
    it "assigns the requested Sections most recent Partition as @partition" do
      mock_statistics = mock_model(Statistic)
      get :latest_statistics, :section => 'edustus'
      assigns(:partition).should == mock_partition
    end
    
    it "assigns nil as @partition if requested Section doesn't have any Partitions" do
      Partition.should_receive(:latest).and_raise(ActiveRecord::RecordNotFound)
      get :latest_statistics, :section => 'edustus'
      assigns(:partition).should == nil
    end
  end
  
  describe "'GET' show_statistics" do
    it "assigns requested Partitions as @partition" do
      Partition.stub(:find).with("3") { mock_partition }
      get :show_statistics, :section => 'edustus', :id => "3"
      assigns(:partition).should == mock_partition
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
  
  describe "'GET' latest_standings" do
    it "assigns requested Section's latest partition as @partition" do
      Partition.stub(:latest).with(@section) { mock_partition }
      get :latest_standings, :section => 'edustus'
      assigns(:partition).should == mock_partition
    end
    
    it "assigns nil as @partition if no partitions are found" do
      get :standings, :section => 'edustus'
      assigns(:partition).should == nil
    end
  end
  
  describe "'GET' show_standings" do
    it "assigns requested Partitions as @partition" do
      Partition.stub(:find).with("3") { mock_partition }
      get :show_standings, :section => 'edustus', :id => "3"
      assigns(:partition).should == mock_partition
    end
  end
  
  describe "'GET' player" do
    it "assigns requested member as @member" do
      mock_player = mock_model(Member)
      Member.should_receive(:find).with("3").and_return(mock_player)
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