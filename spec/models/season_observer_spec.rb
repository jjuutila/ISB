require 'spec_helper'

describe SeasonObserver do
  before(:each) do
    @season = mock_model(Season)
    @player = Factory.create(:member)
  end
  
  context "member is added to a season" do
    before(:each) do                  
      @partition = Partition.create(:season => @season, :position => 1, :name => 'Test')
      @coach = Factory.create(:member)
    end

    it "should create new Statistic when a new player is added to a season" do
      @player.affairs.create :season => @season, :role => 'player'
      
      Statistic.where(:member_id => @player.id, :partition_id => @partition.id).count.should == 1
    end
    
    it "should not create new Statistics" do
      @coach.affairs.create :season => @season, :role => 'coach'
      
      Statistic.where(:member_id => @coach.id, :partition_id => @partition.id).count.should == 0
    end
  end
  
  context "partition is added to a season" do
    before(:each) do
      @player.affairs.create :season => @season, :role => 'player'
      
      @coach = Factory.create(:member)
      @coach.affairs.create :season => @season, :role => 'coach'
    end
    
    it "should create new Statistics for players when a new partition is added to season" do
      Partition.create(:season => @season, :position => 1, :name => 'Test 1')
      Partition.create(:season => @season, :position => 2, :name => 'Test 2')
      
      Statistic.all.count.should == 2
    end
  end
  
  context "player is removed from the season" do
    before(:each) do                  
      @partition = Partition.create(:season => @season, :position => 1, :name => 'Test') 
      @player.affairs.create :season => @season, :role => 'player'
    end
    
    it "should remove Statistic row with all values as 0" do
      Statistic.where(:member_id => @player.id, :partition_id => @partition.id).count.should == 1
      @player.affairs.last.destroy.should
      Statistic.where(:member_id => @player.id, :partition_id => @partition.id).count.should == 0
    end
    
    it "should not remove Statistic row with non zero values" do
      Statistic.where(:member_id => @player.id, :partition_id => @partition.id).count.should == 1
      stats = @player.statistics.last
      stats.matches = 2
      stats.save
      @player.affairs.last.destroy
      Statistic.where(:member_id => @player.id, :partition_id => @partition.id).count.should == 1
    end
  end
  
  context "partition is removed from a season" do    
    it "should remove all Statistics in that partition" do
      partition = Partition.create(:season => @season, :position => 1, :name => 'Test')
      @player.affairs.create :season => @season, :role => 'player'
      partition.destroy
      Statistic.where(:partition_id => partition.id).count.should == 0
    end
  end
end
