# coding: utf-8
require File.expand_path("../../spec_helper.rb", __FILE__)

describe News do
  context "Validations" do
    it { should have_and_belong_to_many(:sections) }
    
    it { should validate_presence_of(:title) }
    it { should_not allow_value("").for(:title) }
    it { should_not allow_value(/\s/).for(:title) }
    it { should ensure_length_of(:title).is_at_least(3) }
    
    it { should validate_presence_of(:content) }
    it { should_not allow_value("").for(:content) }
    it { should_not allow_value("         ").for(:content) }
    
    it { should validate_presence_of(:slug) }
    it { should_not allow_value("").for(:slug) }
  end
  
  context "Make slug" do
    
  end
end