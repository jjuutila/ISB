require 'spec_helper'

describe Match do
  
  context "validations" do
    it { should belong_to(:partition) }
    it { should validate_presence_of(:partition) }
    
    it { should belong_to(:home_team) }
    it { should validate_presence_of(:home_team) }
    
    it { should belong_to(:visitor_team) }
    it { should validate_presence_of(:visitor_team) }
    
    it { should validate_numericality_of(:home_goals) }
    it { should validate_numericality_of(:visitor_goals) }
    it { should validate_presence_of(:location) }
    it { should validate_presence_of(:start_time) }
    
    it "should set base error when teams are the same" do
      team = TeamStanding.new :name => 'a team'
      match = Match.new :home_team => team, :visitor_team => team
      match.valid?.should be_false
      match.errors[:base].count.should == 1
    end
      
    it "should not set base error when teams are nil" do
      match = Match.new
      match.valid?
      match.errors[:base].count.should == 0
    end
    
  end
  
  describe "result" do
    it "should return the match result" do
      match = Match.new :home_goals => 2, :visitor_goals => 3
      match.result.should == "2-3"
    end
  end
  
  describe "to_s" do
    it "should return teams" do
      home_team = TeamStanding.new :name => 'home team'
      visitor_team = TeamStanding.new :name => 'visitor team'
      
      match = Match.new :home_team => home_team, :visitor_team => visitor_team
      match.to_s.should == "home team - visitor team"
    end
  end
  
  describe "scope upcoming" do
    it "gets matches in next 30 days" do
      match_too_late = Match.new :start_time => DateTime.now.advance(:days => 31)
      match_too_late.save :validate => false
      
      match_tomorrow = Match.new :start_time => DateTime.now.advance(:days => 1)
      match_tomorrow.save :validate => false
      
      match_yesterday = Match.new :start_time => DateTime.now.advance(:days => -1)
      match_yesterday.save :validate => false
      
      Match.upcoming.should == [match_tomorrow]
    end
    
    it "gets also past matches from the current day" do
      match_today = Match.new :start_time => DateTime.now.at_beginning_of_day
      match_today.save :validate => false
      
      Match.upcoming.should == [match_today]
    end
  end
end