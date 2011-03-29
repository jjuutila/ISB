require 'spec_helper'

describe Question do
  describe "validations" do
    it { should validate_presence_of(:content) }
    it { should validate_presence_of(:answer) }
    it { should belong_to(:member) }
  end
  
  describe "to_s" do
    it "returns content" do
      question = Question.new :content => "What?"
      question.to_s.should == "What?"
    end
  end
  
  describe "scope unique" do
    it "returns questions with unique content" do
      q1 = Question.new :content => "What is this?"
      q1.save :validate => false
      
      q2 = Question.new :content => "What is this?"
      q2.save :validate => false
      
      q3 = Question.new :content => "Is this something else?"
      q3.save :validate => false
      
      Question.unique.length.should == 2
    end
  end
end
