require 'spec_helper'

describe Statistic do
  context "validations" do
    it { should belong_to(:partition) }
    it { should validate_presence_of(:partition) }
    
    it { should belong_to(:member) }
    it { should validate_presence_of(:member) }
    
    it { should validate_presence_of(:matches) }
    it { should validate_numericality_of(:matches) }
    
    it { should validate_presence_of(:goals) }  
    it { should validate_numericality_of(:goals) }
    
    it { should validate_presence_of(:pim) }
    it { should validate_numericality_of(:pim) }
    
    it { should validate_presence_of(:assists) }
    it { should validate_numericality_of(:assists) }
  end
end
