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
  
  context "to_s" do
    it "should return name" do
      partition = Partition.new(:name => 'Runkosarja')
      partition.to_s.should == 'Runkosarja'
    end
  end
  
  context "latest" do
    it "should find the latest season's last partition" do
      section = Factory.create :section
      latest_season = Season.create :start_year => 2010, :division => "1. divisioona", :section => section
      Season.create :start_year => 2009, :division => "2. divisioona", :section => section
      
      latest_partition = Partition.create :name => 'Playoffs', :position => 2, :season => latest_season
      Partition.create :name => 'Runkosarja', :position => 1, :season => latest_season
      
      Partition.latest(section).should == latest_partition
    end
  end
end