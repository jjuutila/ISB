require 'spec_helper'

describe Affair do
  context "validations" do
    it { should belong_to(:season) }
    it { should belong_to(:member) }    
    it { should validate_presence_of(:member) }    
    it { should validate_presence_of(:season) }    
    it { should validate_presence_of(:role) }
    
    it { should allow_value("player").for(:role) }
    it { should allow_value("assistant").for(:role) }
    it { should allow_value("coach").for(:role) }
  end
  
  context "custom uniqueness validation on create" do
    it "sets error when there is an Affair with same member_id and season_id" do
      Affair.should_receive(:where).with(:member_id => 2, :season_id => 1).and_return([mock_model(Affair)])
      
      affair = Affair.create(:member_id => 2, :season_id => 1)
      
      affair.errors[:unique].should include 'Member already assigned to season.'
    end
    
    it "passes if there is no Affair with same member_id and season_id" do
      Affair.should_receive(:where).with(:member_id => 2, :season_id => 1).and_return([])
      
      affair = Affair.create(:member_id => 2, :season_id => 1)
      
      affair.errors[:unique].count.should == 0
    end
  end
end
