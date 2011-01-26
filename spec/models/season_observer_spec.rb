require 'spec_helper'

describe SeasonObserver do
  def mock_partition(stubs={})
    (@mock_partition ||= mock_model(Partition).as_null_object).tap do |partition|
      partition.stub(stubs) unless stubs.empty?
    end
  end
  
  def mock_affair(stubs={})
    (@mock_affair ||= mock_model(Affair).as_null_object).tap do |affair|
      affair.stub(stubs) unless stubs.empty?
    end
  end
  
  def mock_statistic(stubs={})
    (@mock_statistic ||= mock_model(Statistic).as_null_object).tap do |statistic|
      statistic.stub(stubs) unless stubs.empty?
    end
  end
  
  def test_removes_only_zero_statistics
    non_zero_stats = mock_model(Statistic)
    non_zero_stats.stub("all_0?") {false}
    
    zero_stats = mock_model(Statistic)
    zero_stats.stub("all_0?") {true}
    
    Partition.should_receive(:in_season).with(2) {[mock_partition]}
    
    # Basically only one statistic should be found for one player in one partition,
    # but in this case it doesn't matter.
    Statistic.should_receive(:where).with("partition_id IN (?) AND member_id = ?", [mock_partition.id], 4) {[non_zero_stats, zero_stats]}
    
    zero_stats.should_receive(:destroy)
    
    non_zero_stats.should_not_receive(:destroy)
  end
    
  context "member is added to a season" do
    context "as a player" do
      it "creates a new Statistic" do
        Partition.should_receive(:in_season).with(2) {[mock_partition]}
        
        Statistic.should_receive(:find_or_create_by_member_id_and_partition_id).with(4, mock_partition.id)
      
        SeasonObserver.instance.after_create mock_affair({:season_id => 2, :role => 'player', :member_id => 4})
      end
    end
    
    context "not as a player" do
      it "doesn't create statistics" do
        Partition.should_not_receive(:in_season).with(2) {[mock_partition]}
        SeasonObserver.instance.after_create mock_affair({:season_id => 2, :role => 'coach', :member_id => 4})
      end
    end
  end
  
  context "partition is added to a season" do
    it "creates new Statistics for players" do
      Affair.should_receive(:players_on_season).with(8) {[mock_affair(:member_id => 5)]}
      
      Statistic.should_receive(:find_or_create_by_member_id_and_partition_id).with(5, mock_partition.id)
      
      SeasonObserver.instance.after_create mock_partition(:season_id => 8)
    end
  end
  
  context "member is removed from the season" do
    it "only removes statistics with all 0 values" do
      test_removes_only_zero_statistics
      SeasonObserver.instance.after_destroy mock_affair({:season_id => 2, :member_id => 4})
    end
  end
  
  context "partition is removed from a season" do    
    it "removes all Statistics in that partition" do
      Statistic.should_receive(:where).with("partition_id = ?", mock_partition.id) {[mock_statistic]}
      mock_statistic.should_receive(:destroy)
      SeasonObserver.instance.after_destroy mock_partition
    end
  end
  
  context "member's role in a season is updated" do
    context "to other than 'player'" do
      it "removes statistics that are empty on the affair's season" do
        test_removes_only_zero_statistics
        SeasonObserver.instance.after_update mock_affair({:season_id => 2, :role => 'coach', :member_id => 4})
      end
    end
    
    context "to 'player'" do
      it "creates statistics if not already created" do
        Partition.should_receive(:in_season).with(2) {[mock_partition]}
        
        Statistic.should_receive(:find_or_create_by_member_id_and_partition_id).with(4, mock_partition.id)
        
        SeasonObserver.instance.after_update mock_affair({:season_id => 2, :role => 'player', :member_id => 4})
      end
    end
  end
end
