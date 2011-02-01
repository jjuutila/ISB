require 'spec_helper'

describe Partition do
  def mock_partition(stubs={})
    (@mock_partition ||= mock_model(Partition).as_null_object).tap do |partition|
      partition.stub(stubs) unless stubs.empty?
    end
  end
  
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
  
  context "to_s" do
    it "should return name" do
      partition = Partition.new(:name => 'Runkosarja')
      partition.to_s.should == 'Runkosarja'
    end
  end
  
  context "latest" do
    it "should find the latest season's last partition" do
      section = Factory.build :section
      season = mock_model(Season)
      Season.stub(:latest).with(section) { season }
      Season.create :start_year => 2009, :division => "2. divisioona", :section => section
      
      latest_partition = Partition.create :name => 'Playoffs', :position => 2, :season => season
      Partition.create :name => 'Runkosarja', :position => 1, :season => season
      
      Partition.latest(section).should == latest_partition
    end
    
    it "raises an exception if partition is not found" do
      section = mock_model(Section)
      lambda { Partition.latest(section) }.should raise_error ActiveRecord::RecordNotFound
    end
  end
  
  context "set_position" do
    before(:each) do
      @season = mock_model(Season)
      Season.stub(:find).with(@season.id) { @season }
    end

    it "sets new partitions position to next when no position is set" do
      Partition.stub_chain(:where, :maximum).with(:position) { 1 }
      Partition.should_receive(:where)
      
      new_partition = Partition.create :season => @season, :name => 'foo'
      new_partition.position.should == 2
    end
    
    it "sets new partitions position to 1 when it is the first partition in that season" do
      Partition.stub_chain(:where, :maximum).with(:position) { nil }
      new_partition = Partition.create :season => @season, :name => 'foo'
      new_partition.position.should == 1
    end
    
  end
end