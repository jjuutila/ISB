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
end
