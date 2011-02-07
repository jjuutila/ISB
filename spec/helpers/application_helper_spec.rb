require 'spec_helper'

describe ApplicationHelper do
  describe "html5_datetime" do
    it "returns a time objects value in correct HTML5 format" do
      time = Time.local(2011, "jan",1,20,15,1)
      html5_datetime(time).should == "2011-01-01T20:15:01+01:00"
    end
    
    it "return to_s for other objects" do
      obj = 1
      html5_datetime(obj).should == "1"
    end
  end
end