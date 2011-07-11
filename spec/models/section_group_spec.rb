require 'spec_helper'

describe SectionGroup do
  it { should have_many(:sections) }
  
  it { should validate_presence_of(:name) }
  it { should_not allow_value("").for(:name) }
  
  it { should validate_presence_of(:slug) }
  it { should_not allow_value("").for(:slug) }
end
