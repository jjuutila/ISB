# coding: utf-8

class Admin::NewsController < Admin::BaseController
  respond_to :html
  
  def index
    @selected_section = selected_section
    respond_with @news = News.in_section(@selected_section, params[:page])
  end

  def show
    respond_with @news = News.find(params[:id])
  end

  def new
    respond_with @news = News.new(:sections => [selected_section])
  end

  def edit
    respond_with @news = News.find(params[:id])
  end

  def create
    @news = News.new(params[:news])
    flash.notice = 'Uusi uutinen lisätty.' if @news.save
    respond_with @news, :location => admin_news_index_path
  end

  def update
    @news = News.find(params[:id])
    flash.notice = 'Uutinen päivitetty.' if @news.update_attributes(params[:news])
    respond_with @news, :location => admin_news_index_path
  end

  def destroy
    @news = News.find(params[:id])
    @news.destroy
    respond_with @news, :location => admin_news_index_url
  end
end
