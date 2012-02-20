# coding: utf-8
class NewsController < MainSiteController
  include ActionView::Helpers::TextHelper

  respond_to :html

  def index
    respond_with @news = News.in_section(@section, params[:sivu])
  end
  
  def show
    @news = @section.news.find(params[:slug])

    add_title @news.title
    @meta_description = truncate(@news.content, :length => 120, :separator => ' ')

    respond_with @news
  end
end
