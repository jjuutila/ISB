# coding: utf-8
require 'spec_helper'

describe SectionController do
  def mock_section(stubs={})
    (@mock_section ||= mock_model(Section).as_null_object).tap do |section|
      section.stub(stubs) unless stubs.empty?
    end
  end
  
  def mock_news(stubs={})
    (@mock_news ||= mock_model(News).as_null_object).tap do |news|
      news.stub(stubs) unless stubs.empty?
    end
  end
  
  def mock_partition(stubs={})
    (@mock_partition ||= mock_model(Partition).as_null_object).tap do |partition|
      partition.stub(stubs) unless stubs.empty?
    end
  end
  
  before(:each) do
    Section.should_receive(:find_by_slug).and_return(mock_section)
  end
  
  describe "'GET' news" do
    it "sets requested news posts as @news" do
      News.should_receive(:in_section).with(mock_section) {[mock_news]}
      get :news, :section => 'edustus'
      assigns(:news).should == [mock_news]
    end
  end
  
  describe "'GET' matches" do
    it "sets the latest partition in requested section as @partition" do
      Partition.should_receive(:latest).with(mock_section).and_return(mock_partition)
      
      mock_match = mock_model(Match)
      Match.stub(:where) {[mock_match]}
      
      get :matches, :section => 'edustus'
      assigns(:partition).should == mock_partition
    end
    
    it "sets matches from the newest partition in requested section as @matches" do
      Partition.stub(:latest) {mock_partition}
      
      mock_match = mock_model(Match)
      Match.should_receive(:where).with(:partition_id => mock_partition.id).and_return([mock_match])
      
      get :matches, :section => 'edustus'
      assigns(:matches).should == [mock_match]
    end
  end
  
  describe "'GET' show_match" do
    it "sets the requested match as @match" do
      mock_match = mock_model(Match)
      Match.should_receive(:find).with(3).and_return(mock_match)
      get :show_match, :section => 'edustus', :id => 3
      assigns(:match).should == mock_match
    end
  end
end