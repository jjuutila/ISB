require 'spec_helper'

describe Affair do
  context "validations" do
    it { should belong_to(:season) }
    it { should belong_to(:member) }    
    it { should validate_presence_of(:member) }    
    it { should validate_presence_of(:season) }    
    it { should validate_presence_of(:role) }
  end
end
