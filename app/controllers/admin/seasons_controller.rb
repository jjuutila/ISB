class Admin::SeasonsController < Admin::BaseController
  # GET /admin/seasons
  # GET /admin/seasons.xml
  def index
    @admin_seasons = Admin::Season.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @admin_seasons }
    end
  end

  # GET /admin/seasons/1
  # GET /admin/seasons/1.xml
  def show
    @admin_season = Admin::Season.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @admin_season }
    end
  end

  # GET /admin/seasons/new
  # GET /admin/seasons/new.xml
  def new
    @admin_season = Admin::Season.new

    respond_to do |format|
      format.html # new.html.haml
      format.xml  { render :xml => @admin_season }
    end
  end

  # GET /admin/seasons/1/edit
  def edit
    @admin_season = Admin::Season.find(params[:id])
  end

  # POST /admin/seasons
  # POST /admin/seasons.xml
  def create
    @admin_season = Admin::Season.new(params[:season])

    respond_to do |format|
      if @admin_season.save
        format.html { redirect_to(@admin_season, :notice => 'Season was successfully created.') }
        format.xml  { render :xml => @admin_season, :status => :created, :location => @admin_season }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @admin_season.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin/seasons/1
  # PUT /admin/seasons/1.xml
  def update
    @admin_season = Admin::Season.find(params[:id])

    respond_to do |format|
      if @admin_season.update_attributes(params[:season])
        format.html { redirect_to(admin_seasons_path, :notice => t('.new-instanse-created')) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @admin_season.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/seasons/1
  # DELETE /admin/seasons/1.xml
  def destroy
    @admin_season = Admin::Season.find(params[:id])
    @admin_season.destroy

    respond_to do |format|
      format.html { redirect_to(admin_seasons_url) }
      format.xml  { head :ok }
    end
  end
end
