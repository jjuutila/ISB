require 'spec_helper'

describe User do
  describe "Validations" do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should belong_to(:section) }
    
    describe "section" do
      before(:each) do
        @section = mock_model(Section)
        @user = User.new
        @user.section = @section
      end
    
      it "accepts a leaf section" do
        @section.should_receive(:leaf?) { true }
        @user.valid?
        @user.errors[:section].count.should == 0
      end
      
      it "doesn't accept a top level section" do
        @section.stub(:leaf?).with() { false }
        @user.valid?
        @user.errors[:section].count.should == 1
      end
    end
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
      @section = mock_model(Section)
    end
    
    it "sets User.section as the first leaf section found if User.section is nil" do
      Section.should_receive(:first_leaf!).with().and_return(@section)
      @user.selected_section.should == @section
    end
    
    it "returns the User.section" do
      Section.should_not_receive(:first_leaf!)
      @user.section = @section
      @user.selected_section.should == @section
    end
  end
end
