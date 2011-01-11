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
    it "should print the result" do
      match = Match.new :home_goals => 2, :visitor_goals => 3
      match.result.should == "2-3"
    end
  end
end