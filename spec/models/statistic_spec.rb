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
end
