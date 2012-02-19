# coding: utf-8
class HomeController < ApplicationController
  respond_to :html
  layout 'home'
  
  def index
    @news = News.recent
    @upcoming_matches = Match.upcoming
  end
  
  def show
    @news = News.find params[:id]
    render "show_news"
  end
end