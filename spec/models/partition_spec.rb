require 'spec_helper'

describe Partition do
  context "validations" do
    it { should have_many(:statistics) }
    it { should have_many(:team_standings) }
    it { should have_many(:matches) }
    it { should belong_to(:season) }
    it { should validate_presence_of(:season) }    
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:position) }  
    it { should validate_numericality_of(:position) }
  end
end
