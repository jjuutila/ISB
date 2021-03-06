# coding: utf-8
class Admin::SeasonsController < Admin::BaseController
  respond_to :html
  
  def index
    respond_with @seasons = Season.in_section(selected_section)
  end

  def show
    respond_with @season = Season.find(params[:id])
  end

  def new
    @season = Season.new(:section_id => selected_section.id,
      :partitions => [Partition.new(:name => 'Runkosarja')])
    respond_with @season
  end

  def edit
    @season = Season.find(params[:id])
  end

  def create
    @season = Season.new(params[:season])
    # respond_with cannot be used because it doesn't seem to work properly when creating
    # nested models: if an error exists in the underlying model
    if @season.save
      flash[:notice] = "Uusi kausi luotu."
      redirect_to admin_season_path(@season)
    else
      render "new"
    end
  end

  def update
    @season = Season.find(params[:id])
    flash[:notice] = 'Kausi päivitetty.' if @season.update_attributes(params[:season])
    respond_with @season, :location => admin_season_path(@season)
  end

  def destroy
    @admin_season = Season.find(params[:id])
    @admin_season.destroy

    respond_to do |format|
      format.html { redirect_to(admin_seasons_url) }
    end
  end
end
