require 'spec_helper'

describe Partition do
  context "validations" do
    it { should have_many(:statistics) }
    it { should have_many(:team_standings) }
    it { should have_many(:matches) }
    it { should belong_to(:season) }    
    it { should validate_presence_of(:season) }    
    it { should validate_presence_of(:name) }    
    it { should validate_presence_of(:position) }  
    it { should validate_numericality_of(:position) }
  end
  
  context "player statistics" do
    before(:each) do
      season = mock_model(Season)            
      @partition = Partition.create(:season => season, :position => 1, :name => 'Test') 
           
      @player = Factory.create(:member)
      @player.affairs.create :season => season, :role => 'player'
            
      @coach = Factory.create(:member)
      @coach.affairs.create :season => season, :role => 'coach'
    end
    
    it "should get all players on the season and statistics for the partition" do
      Factory.create(:statistic, :member => @player, :partition => @partition)
      check_player_statistics_results
    end
    
    it "shoud create new statistics if needed" do
      check_player_statistics_results
    end
    
    it "should not include players from other seasons" do
      other_season = mock_model(Season)
      other_partition = Partition.new(:season => other_season, :position => 1, :name => 'Test')
      
      other_player = Factory.create(:member)
      other_player.affairs.create :season => other_season, :role => 'player'
      
      check_player_statistics_results
    end
    
    def check_player_statistics_results
      stats = @partition.player_statistics
      stats.count.should == 1
      stats.first.statistics.count.should == 1
    end
  end
end
