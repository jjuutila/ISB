require 'spec_helper'

describe GlobalMenuHelper do
  describe "generate_global_menu_items" do
    before(:each) do
      @section_groups = FactoryGirl.build_list(:section_group, 2)
      @section_groups[0].sections = FactoryGirl.build_list(:section, 2, :group => @section_groups[0])
      @section_groups[1].sections = FactoryGirl.build_list(:section, 2, :group => @section_groups[1])
    end
    
    it "has front page item as first" do
      generate_global_menu_items[0][:key].should == :front_page
    end
    
    it "has has 4 SectionGroups" do
      generate_global_menu_items.length == 3
    end
    
    it "has 2 sub items in its first SectioGroup item" do
      generate_global_menu_items[1][:items].count.should == 2
    end
  end
end
