require 'spec_helper'
# Specs in this file have access to a helper object that includes
# the SectionsHelper. For example:
#
# describe SectionsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       helper.concat_strings("this","that").should == "this that"
#     end
#   end
# end

describe Admin::SectionsHelper do
  describe "section selection" do
    
    before(:each) do                  
      @root = Factory.create :section
      @child = Factory.create :section, :parent => @root 
    end
    
    it "should create section selection form" do
      output = section_selection
      output.should include 'form'
      output.should include 'submit'
    end
    
    it "should contain sections" do
      output = section_selection
      output.should_not include @root.id
      output.should include @child.id.to_s
      output.should include @child.name
    end
  end
end