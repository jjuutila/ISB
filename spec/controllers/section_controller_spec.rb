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
  
end