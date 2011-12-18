# coding: utf-8
require 'spec_helper'

describe Comment do
  context "validations" do
    it { should validate_presence_of(:commentable) }
    
    it { should ensure_length_of(:title).is_at_most(60).with_long_message(/pitkä/) }
    
    it { should ensure_length_of(:content).is_at_least(2).with_short_message(/lyhyt/) }
    it { should ensure_length_of(:author).is_at_least(1).is_at_most(40).with_short_message("Anna nimimerkki.").with_long_message(/pitkä/) }
    
    it "should not be valid if honeypot is not the honeypot secret value" do
      c = Comment.new(:honeypot => 'foobar')
      c.valid?
      c.errors.include?(:honeypot).should be true
    end
  end
  
  context "to_s" do
    it "returns the title" do
      c = Comment.new :title => "FooBar"
      c.to_s.should == "FooBar"
    end
  end
end
