# coding: utf-8
class NewsController < MainSiteController
  respond_to :html

  def index
    respond_with @news = News.in_section(@section, params[:sivu])
  end
  
  def show
    respond_with @news = @section.news.find(params[:slug])
  end
end
