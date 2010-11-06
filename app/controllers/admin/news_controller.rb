# coding: utf-8

class Admin::NewsController < Admin::BaseController
  # GET /admin/news
  # GET /admin/news.xml
  def index
    @selected_section = selected_section
    
    @news = News.in_section(@selected_section)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @news }
    end
  end

  # GET /admin/news/1
  # GET /admin/news/1.xml
  def show
    @news = Admin::News.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @news }
    end
  end

  # GET /admin/news/new
  # GET /admin/news/new.xml
  def new
    @news = News.new(:sections => [selected_section])
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @news }
    end
  end

  # GET /admin/news/1/edit
  def edit
    @news = News.find(params[:id])
  end

  # POST /admin/news
  # POST /admin/news.xml
  def create
    @news = News.new(params[:news])

    respond_to do |format|
      if @news.save
        format.html { redirect_to(admin_news_index_path, :notice => 'Uusi uutinen lisätty.') }
        format.xml  { render :xml => @news, :status => :created, :location => admin_news_index_path }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @news.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin/news/1
  # PUT /admin/news/1.xml
  def update
    @news = Admin::News.find(params[:id])

    respond_to do |format|
      if @news.update_attributes(params[:news])
        format.html { redirect_to(admin_news_index_path, :notice => 'Uutinen päivitetty.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @news.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/news/1
  # DELETE /admin/news/1.xml
  def destroy
    @news = News.find(params[:id])
    @news.destroy

    respond_to do |format|
      format.html { redirect_to(admin_news_index_url) }
      format.xml  { head :ok }
    end
  end
end
