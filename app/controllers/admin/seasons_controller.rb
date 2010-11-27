# coding: utf-8
class Admin::SeasonsController < Admin::BaseController
  respond_to :html
  
  def index
    @seasons = Season.where(:section_id => selected_section.id)
    respond_with @seasons
  end

  # GET /admin/seasons/1
  # GET /admin/seasons/1.xml
  def show
    @admin_season = Season.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @admin_season }
    end
  end

  def new
    @season = Season.new(:section_id => selected_section.id,
      :partitions => [Partition.new(:name => 'Runkosarja', :position => 1)])
    respond_with @season
  end

  # GET /admin/seasons/1/edit
  def edit
    @season = Season.find(params[:id])
  end

  # POST /admin/seasons
  # POST /admin/seasons.xml
  def create
    @season = Season.new(params[:season])
    @season.partitions.first.position = 1
    @season.save
    
    flash[:notice] = "Uusi kausi luotu." unless @season.new_record?
    respond_with @season, :location => admin_seasons_path
  end

  # PUT /admin/seasons/1
  # PUT /admin/seasons/1.xml
  def update
    @season = Season.find(params[:id])
    
    if @season.update_attributes(params[:season])
      flash[:notice] = 'Kausi päivitetty.'
    end
    respond_with @season, :location => admin_seasons_url
  end

  # DELETE /admin/seasons/1
  # DELETE /admin/seasons/1.xml
  def destroy
    @admin_season = Season.find(params[:id])
    @admin_season.destroy

    respond_to do |format|
      format.html { redirect_to(admin_seasons_url) }
      format.xml  { head :ok }
    end
  end
end
