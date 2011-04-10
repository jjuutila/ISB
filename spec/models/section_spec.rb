# coding: utf-8
require 'spec_helper'

describe Section do
  context "validations" do
    it { should belong_to(:parent) }
    it { should have_many(:sections) }
    it { should have_many(:seasons) }
    
    it { should have_and_belong_to_many(:news) }

    it { should have_many(:comments) }
      
    it { should validate_presence_of(:name) }
    it { should_not allow_value("").for(:name) }
    
    it { should validate_presence_of(:slug) }
    
    it { should have_many(:link_categories) }
  end
  
  context "top_level" do
    it "gets all sections with child sections" do
      parent = Section.new :name => "Parent"
      parent.save :validate => false
      
      child = Section.new :name => "Child", :parent => parent
      child.save :validate => false
      
      other_parent = Section.new :name => "Other Parent"
      other_parent.save :validate => false
      
      Section.top_level.should == [parent, other_parent]
    end
  end
end