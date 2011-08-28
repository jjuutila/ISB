# coding: utf-8
require File.expand_path("../../spec_helper.rb", __FILE__)

describe Season do
  context "Validations" do
    it { should belong_to(:section) }
    it { should have_many(:partitions) }
    it { should have_many(:members) }
    it { should validate_presence_of(:section) }
    it { should validate_presence_of(:division) }
    it { should_not allow_value("").for(:division) }
    it { should validate_presence_of(:start_year).with_message(/aloitusvuosi/) }
    it { should validate_numericality_of(:start_year).with_message(/aloitusvuosi/) }
    #it { should ensure_inclusion_of(:start_year).in_range(2000..0).with_message(/aloitusvuosi/) }
  end
  
  context "Printing" do
    before(:each) do
      @season = Season.new(:start_year => 2009, :division => "1. divisioona")      
    end
    
    it "Should print season and division" do
      @season.to_s.should == "2009-2010, 1. divisioona"
    end
  end
  
  context "latest" do
    it "finds the latest season" do
      section = mock_model(Section)
      latest_season = Season.create :start_year => 2010, :division => "1. divisioona", :section => section
      Season.create :start_year => 2009, :division => "2. divisioona", :section => section
      
      Season.latest(section).should == latest_season
    end
    
    it "throws exception when no season is found" do
      section = mock_model(Section)
      lambda { Season.latest(section) }.should raise_error ActiveRecord::RecordNotFound
    end
  end

  context "configure default partition" do
    it "sets self as partition.season before partition" do
      season = Season.new :partitions_attributes => {"0" => {:name => "default"}}
      season.valid?
      season.partitions.first.season.should == season
    end
  end
  
  context "all_except_newest" do
    it "get all Seasons except the newest Season in the given Section" do
      section = mock_model(Section)
      other_section = mock_model(Section)
      
      seasons = FactoryGirl.create_list(:season, 3, :section => section).reverse
      seasons.delete seasons[0]
      
      FactoryGirl.create(:season, :section => other_section)
      
      Season.all_except_newest(section).should eq seasons
    end
  end
  
  context "has_history?" do
    it "is true if Season has a history text" do
      s = Season.new :history => "some text"
      s.has_history?.should be true
    end
  end
end