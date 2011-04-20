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
end
