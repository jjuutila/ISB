require 'spec_helper'

describe TeamStanding do
  context "validations" do
    it { should belong_to(:partition) }
    it { should validate_presence_of(:partition) }
    
    it { should have_many(:home_matches) }
    it { should have_many(:visitor_matches) }
    
    it { should validate_presence_of(:name) }
    
    it { should validate_numericality_of(:wins) }
    it { should validate_numericality_of(:losses) }
    it { should validate_numericality_of(:overtimes) }
    it { should validate_numericality_of(:goals_for) }
    it { should validate_numericality_of(:goals_against) }
    it { should validate_numericality_of(:rank) }
  end
  
  context "after initialization" do
    it "numerical fields should be set to 0 if they are not set" do
      standing = TeamStanding.new
      standing.wins.should == 0
      standing.losses.should == 0
      standing.overtimes.should == 0
      standing.goals_for.should == 0
      standing.goals_against.should == 0
    end
    
    it "should not set 0 value to field that is not nil" do
      standing = TeamStanding.new :wins => 1
      standing.wins.should == 1
      standing.losses.should == 0
      standing.overtimes.should == 0
      standing.goals_for.should == 0
      standing.goals_against.should == 0
    end
  end
  
  context "points" do
    it "should give two points for a win" do
      standing = TeamStanding.new :wins => 2
      standing.points.should == 4
    end
    
    it "should give one point for overtime" do
      standing = TeamStanding.new :overtimes => 2
      standing.points.should == 2
    end
    
    it "should give zero points for losses" do
      standing = TeamStanding.new :losses => 2
      standing.points.should == 0
    end
  end
  
  context "games played" do
    it "should sum wins, losses and overtimes" do
      standing = TeamStanding.new :losses => 2, :wins => 1, :overtimes => 0
      standing.games_played.should == 3
    end
  end
end
