require 'spec_helper'

describe Comment do
  context "validations" do
    it { should validate_presence_of(:commentable) }
    
    it { should ensure_length_of(:title).is_at_least(2).is_at_most(60).with_short_message(/lyhyt/).with_long_message(/pitkä/) }
    
    it { should ensure_length_of(:content).is_at_least(5).is_at_most(320).with_short_message(/lyhyt/).with_long_message(/pitkä/) }
    it { should ensure_length_of(:author).is_at_least(1).is_at_most(40).with_short_message("Anna nimimerkki.").with_long_message(/pitkä/) }
    
  end
  
  context "to_s" do
    it "returns the title" do
      c = Comment.new :title => "FooBar"
      c.to_s.should == "FooBar"
    end
  end
end