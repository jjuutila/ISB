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
end