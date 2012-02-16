# coding: utf-8
require 'spec_helper'

describe HomeController do
  def mock_news(stubs={})
    (@mock_news ||= mock_model(News).as_null_object).tap do |news|
      news.stub(stubs) unless stubs.empty?
    end
  end
  
  def mock_match(stubs={})
    @mock_match ||= mock_model(::Match, stubs).as_null_object
  end
  
  describe "GET 'index'" do
    it "sets 10 most recent news as @news" do
      News.should_receive(:recent) {[mock_news]}
      get "index"
      assigns(:news).should == [mock_news]
    end
    
    it "sets upcoming matches for the next 30 days as @upcoming_matches" do
      ::Match.should_receive(:upcoming) {[mock_match]}
      get "index"
      assigns(:upcoming_matches).should == [mock_match]
    end
  end
  
  describe "GET 'show'" do
    it "sets the request post as @news" do
      News.should_receive(:find).with("3") {mock_news}
      get "show", :id => 3
      assigns(:news).should == mock_news
    end
    
    it "renders template news/show" do
      News.stub(:find) {mock_news}
      get "show", :id => 3
      response.should render_template("news/show")
    end
  end
end
