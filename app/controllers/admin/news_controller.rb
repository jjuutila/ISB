# coding: utf-8

class Admin::NewsController < Admin::BaseController
  respond_to :html
  before_filter :get_sections, :only => [:new, :edit, :create, :update]
  
  def index
    respond_with @news = News.in_section(selected_section, params[:sivu])
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
  
  private
  
  def get_sections
    @sections = Section.visible
  end
end
