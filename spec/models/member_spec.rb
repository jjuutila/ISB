# coding: utf-8
require 'spec_helper'

describe Member do
  context "validations" do
    it { should have_many(:seasons).through(:affairs) } 
    
    it { should have_many(:statistics) }
    
    it { should validate_presence_of(:first_name) }
    
    it { should validate_presence_of(:last_name) }
    
    it { should validate_numericality_of(:all_time_assists).with_message(/Syötöt tulee olla/) }
    it { should ensure_inclusion_of(:all_time_assists).in_range(0..999).with_message(/Syötöt tulee olla/) }
    
    it { should validate_numericality_of(:all_time_goals).with_message(/Maalit tulee olla/) }
    it { should ensure_inclusion_of(:all_time_goals).in_range(0..999).with_message(/Maalit tulee olla/) }
    
    it { should validate_presence_of(:number) }
    it { should validate_numericality_of(:number).with_message(/Numero tulee olla/) }
    it { should ensure_inclusion_of(:number).in_range(0..99).with_message(/Numero tulee olla/) }
    
    it {should ensure_inclusion_of(:birth_year).in_range(1900..DateTime::now().year()).with_message(/Syntymävuosi/) }
    
    it { should ensure_inclusion_of(:position).in_range(0..3).with_message(/pelipaikka/) }
  end
  
  context "printing" do
    it "returns number of all time points" do
      member = Factory.build(:member, :all_time_assists => 32, :all_time_goals => 3)
      member.all_time_points.should == 38
    end
  end
  
  context "initalization" do
    it "sets alltime values to 0 if not set previously" do
      member = Member.new
      member.all_time_assists.should == 0
      member.all_time_goals.should == 0
    end
    
    it "doesn't change alltime values if set previously" do
      member = Member.new :all_time_assists => 3, :all_time_goals => 12
      member.all_time_assists.should == 3
      member.all_time_goals.should == 12
    end
  end  
end