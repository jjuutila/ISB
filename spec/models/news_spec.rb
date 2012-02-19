# coding: utf-8
require 'spec_helper'

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
  
  context "slug" do
    before(:each) do
      @section = Factory.build(:section)
    end

    it "is generated on update" do  
      news = Factory.create(:news, :title => "Tämä on otsikko.", :sections => [@section])
      news.slug.should == "tama-on-otsikko"
    end

    it "is updated on update" do
      news = Factory.create(:news, :sections => [@section])
      
      news.title = 'Updated title'
      news.save

      news.slug.should == 'updated-title'
    end

    it "is created unique" do
      Factory.create(:news, :title => "Common title", :sections => [@section])

      news = Factory.create(:news, :title => "Common title", :sections => [@section])

      news.slug.should == 'common-title--2'
    end

    it "is updated unique" do
      Factory.create(:news, :title => "Common title", :sections => [@section])
      news = Factory.create(:news, :title => "Other title", :sections => [@section])
      
      news.title = 'Common title'
      news.save

      news.slug.should == 'common-title--2'
    end
  end
end
