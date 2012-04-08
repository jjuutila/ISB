# coding: utf-8
require 'spec_helper'

describe Member do
  context "validations" do
    it { should have_many(:seasons).through(:affairs) } 
    
    it { should have_many(:statistics) }
    
    it { should have_many(:questions) }
    
    it { should validate_presence_of(:first_name) }
    
    it { should validate_presence_of(:last_name) }
    
    it { should validate_numericality_of(:all_time_assists).with_message(/Syötöt tulee olla/) }
    it { should ensure_inclusion_of(:all_time_assists).in_range(0..999).with_message(/Syötöt tulee olla/) }
    
    it { should validate_numericality_of(:all_time_goals).with_message(/Maalit tulee olla/) }
    it { should ensure_inclusion_of(:all_time_goals).in_range(0..999).with_message(/Maalit tulee olla/) }
    
    it { should validate_presence_of(:number) }
    it { should validate_numericality_of(:number).with_message(/Numero tulee olla/) }
    it { should ensure_inclusion_of(:number).in_range(0..99).with_message(/Numero tulee olla/) }
    
    it {should ensure_inclusion_of(:birth_year).in_range(1900..DateTime::now().year()).with_message(/Syntymävuosi/) }
    
    it { should ensure_inclusion_of(:position).in_range(0..3).with_message(/pelipaikka/) }
    
    it { should allow_value("right").for(:shoots) }
    it { should allow_value("left").for(:shoots) }
    it { should allow_value(nil).for(:shoots) }
    it { should allow_value("").for(:shoots) }
    it { should_not allow_value("srhg").for(:shoots) }
    
    it { should validate_attachment_content_type(:photo).
          allowing('image/png', 'image/jpg', 'image/jpeg').
          rejecting('text/plain', 'text/xml') }
          
    it { should validate_attachment_size(:photo).less_than(20.megabytes) }
  end
  
  context "before validations" do
    it "sets alltime values to 0 if not set previously" do
      member = Member.new

      member.valid?

      member.all_time_assists.should == 0
      member.all_time_goals.should == 0
    end
    
    it "doesn't change alltime values if set previously" do
      member = Member.new :all_time_assists => 3, :all_time_goals => 12

      member.valid?

      member.all_time_assists.should == 3
      member.all_time_goals.should == 12
    end
  end
  
  context "all-time points" do
    it "sums the the goals and assists" do
      member = Member.new :all_time_goals => 5, :all_time_assists => 3

      member.valid?

      member.all_time_points.should == 8
    end
  end
  
  context "with_role_in_season" do
    before(:each) do
      @season = mock_model(Season)
      
      @player = FactoryGirl.create(:member)
      @player.affairs.create(:season => @season, :role => "player")
      
      @coach = FactoryGirl.create(:member)
      @coach.affairs.create(:season => @season, :role => "coach")
    end
    
    it "gets members assigned as player in specified season" do
      Member.with_role_in_season("player", @season).should == [@player]
    end
    
    it "gets members assigned as coach in specified season" do
      Member.with_role_in_season("coach", @season).should == [@coach]
    end
  end
  
  context "players_with_points_in_any_season" do
    before(:each) do
      season = mock_model(Season)
      
      @player_with_points = FactoryGirl.create(:member, :all_time_goals => 4, :gender => true)
      @player_with_points.affairs.create(:season => season, :role => "player")
      
      player_with_no_points = FactoryGirl.create(:member, :all_time_goals => 0, :all_time_assists => 0, :gender => true)
      player_with_no_points.affairs.create(:season => season, :role => "player")
      
      female_with_points = FactoryGirl.create(:member, :all_time_goals => 9, :gender => false)
      female_with_points.affairs.create(:season => season, :role => "player")
      
      coach = FactoryGirl.create(:member)
      coach.affairs.create(:season => season, :role => "coach")
    end
    
    it "gets only male members that are assigned to a season as a player and have all-time points" do
      Member.players_with_points_in_any_season(true).should == [@player_with_points]
    end
    
    it "gets a player only once even if the player is on many seasons" do
      # Other season for checking duplicates
      other_season = mock_model(Season)
      @player_with_points.affairs.create(:season => other_season, :role => "player")
      
      Member.players_with_points_in_any_season(true).should == [@player_with_points]
    end
  end
end
