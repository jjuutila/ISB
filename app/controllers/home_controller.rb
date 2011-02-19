# coding: utf-8
class HomeController < ApplicationController
  respond_to :html
  
  def index
    @news = News.recent
  end
  
  def show
    @news = News.find params[:id]
    render "news/show"
  end
end