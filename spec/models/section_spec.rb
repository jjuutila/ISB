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
  
  context "first_leaf!" do
    before(:each) do
      @root_section = Factory.create(:section)
    end
    
    it "returns the first leaf Section" do
      leaf_section = Factory.create(:section, :parent => @root_section)
      other_leaf_section = Factory.create(:section, :parent => @root_section)
      Section.first_leaf!.should == leaf_section
    end
    
    it "raises a RecordNotFound if a leaf Section isn't found" do
      lambda { Section.first_leaf! }.should raise_error ActiveRecord::RecordNotFound
    end
  end
  
  context "leaf?" do
    it "is true when Section has a parent" do
      parent = Section.new
      leaf = Section.new :parent => parent
      leaf.leaf?.should be true
    end
    
    it "is true when Section has parent_id set" do
      leaf = Section.new :parent_id => 2
      leaf.leaf?.should be true
    end
    
    it "is false when Section doesn't have parent or parent_id" do
      leaf = Section.new
      leaf.leaf?.should be false
    end
  end
end
