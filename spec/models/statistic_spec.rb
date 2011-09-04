require 'spec_helper'

describe Statistic do
  context "validations" do
    it { should belong_to(:partition) }
    it { should validate_presence_of(:partition) }
    
    it { should belong_to(:member) }
    it { should validate_presence_of(:member) }
    
    it { should validate_numericality_of(:matches) }
    it { should validate_numericality_of(:goals) }
    it { should validate_numericality_of(:pim) }
    it { should validate_numericality_of(:assists) }
    
    it "should initialize default values" do
      statistic = Statistic.new
      statistic.valid?
      statistic.goals.should == 0
      statistic.assists.should == 0
      statistic.pim.should == 0
      statistic.matches.should == 0
    end
  end
  
  context "points" do
    it "should give correct points" do
      statistic = Statistic.new :goals => 2, :assists => 3
      statistic.points.should == 5
    end
  end
  
  context "all_0?" do
    before(:each) do      
      @statistic = Statistic.new(:goals => 0, :assists => 0, :matches => 0, :pim => 0)
    end
    
    it "should return true if matches, goals, assists and pim are 0" do
      @statistic.all_0?.should == true
    end
    
    it "should return false when assists is > 0" do
      @statistic.assists = 7
      @statistic.all_0?.should == false
    end
    
    it "should return false when pim is > 0" do
      @statistic.pim = 4
      @statistic.all_0?.should == false
    end
    
    it "should return false when matches is > 0" do
      @statistic.matches = 1
      @statistic.all_0?.should == false
    end
    
    it "should return false when goals is > 0" do
      @statistic.goals = 2
      @statistic.all_0?.should == false
    end
  end
  
  context "custom uniqueness validation on create" do
    it "sets error when there is an Statistic with same member_id and partition_id" do
      Statistic.should_receive(:where).with(:member_id => 2, :partition_id => 1).and_return([mock_model(Statistic)])
      
      statistic = Statistic.create(:member_id => 2, :partition_id => 1)
      
      statistic.errors[:unique].should include 'Member already has statistics.'
    end
    
    it "passes if there is no Statistic with same member_id and partition_id" do
      Statistic.should_receive(:where).with(:member_id => 2, :partition_id => 1).and_return([])
      
      statistic = Statistic.create(:member_id => 2, :partition_id => 1)
      
      statistic.errors[:unique].count.should == 0
    end
  end
  
  context "scope with_matches" do
    it "gets only rows where matches > 0" do
      members = FactoryGirl.create_list(:member, 3)
      partition = mock_model(Partition)
      
      Statistic.create!(:member => members[0], :partition => partition)
      with_matches = Statistic.create!(:matches => 21, :member => members[1], :partition => partition)
      Statistic.create!(:goals => 11, :member => members[2], :partition => partition)
      
      Statistic.with_matches.should == [with_matches]
    end
  end
end
