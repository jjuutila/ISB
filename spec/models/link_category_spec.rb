require 'spec_helper'

describe LinkCategory do
  context "validations" do
    it { should belong_to(:section) }
    it { should validate_presence_of(:section) }
    it { should have_many(:links) }
    it { should validate_presence_of(:name) }
  end
  
  context "to_s" do
    it "returns the name" do
      category = LinkCategory.new :name => "Cat Videos"
      category.to_s.should == "Cat Videos"
    end
  end
end
