require 'spec_helper'

describe Admin::QuestionsHelper do
  describe "make string array" do
    it "creates an array in a string" do
      questions = [Question.new(:content => "What?"), Question.new(:content => "How much?")]
      make_string_array(questions).should == '["What?", "How much?"]'
    end
    
    it "adds a backslash in front of a double quote" do
      questions = [Question.new(:content => 'How much"?')]
      make_string_array(questions).should == '["How much\\"?"]'
    end
  end
end