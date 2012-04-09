require 'spec_helper'

describe PartitionObserver do
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
  
  context "partition is added to a season" do
    it "creates new Statistics for players" do
      Affair.should_receive(:players_on_season).with(8) {[mock_affair(:member_id => 5)]}
      
      Statistic.should_receive(:find_or_create_by_member_id_and_partition_id).with(5, mock_partition.id)
      
      PartitionObserver.instance.after_create mock_partition(:season_id => 8)
    end
  end
  
  context "partition is removed from a season" do    
    it "removes all Statistics in that partition" do
      Statistic.should_receive(:where).with("partition_id = ?", mock_partition.id) {[mock_statistic]}
      mock_statistic.should_receive(:destroy)
      PartitionObserver.instance.after_destroy mock_partition
    end
  end
end
