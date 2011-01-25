require 'spec_helper'

describe Link do
  describe "validations" do
    it { should belong_to(:category) }
    it { should validate_presence_of(:category) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:url) }  
  end
  
  describe "to_s" do
    it "returns the name" do
      link = Link.new :name => "FooBar"
      link.to_s.should == "FooBar"
    end
  end  
end
