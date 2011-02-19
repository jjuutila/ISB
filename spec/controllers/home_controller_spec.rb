# coding: utf-8
require 'spec_helper'

describe HomeController do
  def mock_news(stubs={})
    (@mock_news ||= mock_model(News).as_null_object).tap do |news|
      news.stub(stubs) unless stubs.empty?
    end
  end
  
  describe "GET 'index'" do
    it "sets 10 most recent news as @news" do
      News.should_receive(:recent) {[mock_news]}
      get "index"
      assigns(:news).should == [mock_news]
    end
  end
  
  describe "GET 'show'" do
    it "sets the request post as @news" do
      News.should_receive(:find).with(3) {mock_news}
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
