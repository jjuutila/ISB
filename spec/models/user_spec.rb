require 'spec_helper'

describe User do
  describe "Validations" do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should belong_to(:section) }
  end
  
  describe "to_s" do
    it "returns full name" do
      user = User.new(:first_name => "John", :last_name => "Doe")
      user.to_s.should == "John Doe"
    end
  end
  
  describe "selected_section" do
    before(:each) do
      @user = User.new(:first_name => "John", :last_name => "Doe")
      @section = FactoryGirl.create :section
    end
    
    it "sets User.section as the first leaf section found if User.section is nil" do
      @user.selected_section.should == @section
    end
    
    it "returns the User.section" do
      Section.should_not_receive(:first!)
      @user.section = @section
      @user.selected_section.should == @section
    end
  end
end
