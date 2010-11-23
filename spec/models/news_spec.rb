# coding: utf-8
require File.expand_path("../../spec_helper.rb", __FILE__)

describe News do
  context "validating" do
    it { should have_and_belong_to_many(:sections) }
    it { should validate_presence_of(:sections) }
    
    it "should not accept root level section" do
      root_level_section = Factory.create(:section)
      news = Factory.build(:news, :sections => [root_level_section])
      news.valid?.should == false
    end
    
    it { should validate_presence_of(:title) }
    it { should_not allow_value("").for(:title) }
    it { should ensure_length_of(:title).is_at_least(3).with_message(/Otsikko on liian lyhyt/) }
    
    it { should validate_presence_of(:content) }
    it { should_not allow_value("").for(:content) }
    it { should_not allow_value("         ").for(:content) }
    
    it { should validate_presence_of(:slug) }
    it { should_not allow_value("").for(:slug) }
  end
  
  context "is created" do
    it "should have a slug" do
      root_level_section = Factory.create(:section)
      section = Factory.create(:section, :parent => root_level_section)
      news = Factory.create(:news, :title => "Tämä on otsikko.", :sections => [section])
      news.slug.should =="tama-on-otsikko"
    end
  end
end