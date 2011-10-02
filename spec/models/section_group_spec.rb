require 'spec_helper'

describe SectionGroup do
  it { should have_many(:sections) }
  
  it { should validate_presence_of(:name) }
  it { should_not allow_value("").for(:name) }
  
  it { should validate_presence_of(:slug) }
  it { should_not allow_value("").for(:slug) }
  
  describe "first_sections_slug" do
    before(:each) do
      @section_group = FactoryGirl.build(:section_group)
    end
    
    it "returns slug of the its first Section" do
      @section_group.sections.push FactoryGirl.build(:section, :slug => 'first', :group => @section_group)
      @section_group.sections.push FactoryGirl.build(:section, :slug => 'second', :group => @section_group)
      @section_group.first_sections_slug.should == 'first'
    end
    
    it "returns nil if it has no Sections" do
      @section_group.first_sections_slug.should == nil
    end
  end
end
