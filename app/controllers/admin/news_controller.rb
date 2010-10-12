class Admin::NewsController < ApplicationController
  # GET /admin/news
  # GET /admin/news.xml
  def index
    @news = Admin::News.all

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
    @news = Admin::News.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @news }
    end
  end

  # GET /admin/news/1/edit
  def edit
    @news = Admin::News.find(params[:id])
  end

  # POST /admin/news
  # POST /admin/news.xml
  def create
    @news = Admin::News.new(params[:admin_news])

    respond_to do |format|
      if @news.save
        format.html { redirect_to(@news, :notice => 'News was successfully created.') }
        format.xml  { render :xml => @news, :status => :created, :location => @admin_news }
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
      if @news.update_attributes(params[:admin_news])
        format.html { redirect_to(@news, :notice => 'News was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @anews.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/news/1
  # DELETE /admin/news/1.xml
  def destroy
    @news = Admin::News.find(params[:id])
    @news.destroy

    respond_to do |format|
      format.html { redirect_to(admin_news_index_url) }
      format.xml  { head :ok }
    end
  end
end
