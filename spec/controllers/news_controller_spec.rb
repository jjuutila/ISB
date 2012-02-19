# coding: utf-8
require 'spec_helper'

describe NewsController do
  create_section

  describe "'GET' news" do
    it "sets requested news posts as @news" do
      news = Factory.create :news, :sections => [@section]
      get :index, :section => 'edustus'
      assigns(:news).should == [news]
    end
  end
  
  describe "'GET' show_news_post" do
    it "sets the requested news post as @news" do
      news = Factory.create :news, :sections => [@section]
      get :show, :section => 'edustus', :id => news.id 
      assigns(:news).should == news
    end
  end
end
