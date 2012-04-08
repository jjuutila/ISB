# coding: utf-8
require 'spec_helper'

describe NewsController do
  create_section

  describe "'GET' index" do
    it "sets requested news posts as @news" do
      news = FactoryGirl.create :news, :sections => [@section]
      get :index, :section => 'edustus'
      assigns(:news).should == [news]
    end
  end
  
  describe "'GET' show" do
    it "sets the requested news post as @news" do
      news = FactoryGirl.create :news, :sections => [@section]
      get :show, :section => 'edustus', :slug => news.id 
      assigns(:news).should == news
    end
  end
end
