# coding: utf-8
require File.expand_path("../../spec_helper.rb", __FILE__)

describe Section do
  context "validations" do
    it { should belong_to(:parent) }
    it { should have_many(:sections) }
    
    it { should have_and_belong_to_many(:news) }

    it { should have_many(:comments) }
      
    it { should validate_presence_of(:name) }
    it { should_not allow_value("").for(:name) }
    
    it { should validate_presence_of(:slug) }
    
    it { should have_many(:link_categories) }
  end
end