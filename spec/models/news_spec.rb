# coding: utf-8
require File.expand_path("../../spec_helper.rb", __FILE__)

describe News do
  context "validating" do
    it { should have_and_belong_to_many(:sections) }
    it { should validate_presence_of(:sections) }
    
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
      section = Factory.build(:section)
      news = Factory.create(:news, :title => "Tämä on otsikko.", :sections => [section])
      news.slug.should == "tama-on-otsikko"
    end
  end
end
