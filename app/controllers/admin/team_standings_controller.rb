# coding: utf-8
class Admin::TeamStandingsController < Admin::BaseController
  before_filter :get_season_and_partition, :except => [:latest]
  respond_to :html

  def new
    respond_with @team = TeamStanding.new(:partition_id => params[:partition_id])
  end

  def edit
    @admin_team_standind = TeamStanding.find(params[:id])
  end

  def create
    @team = TeamStanding.new(params[:team_standing].merge(:partition => @partition))
    flash.notice = 'Uusi joukkue luotu.' if @team.save
    respond_with @team, :location => admin_season_partition_path(@season, @partition)
  end

  def update
    @admin_team_standind = TeamStanding.find(params[:id])

    respond_to do |format|
      if @admin_team_standind.update_attributes(params[:admin_team_standind])
        format.html { redirect_to(@admin_team_standind, :notice => 'Team standind was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @admin_team_standind.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @team = TeamStanding.find(params[:id])
    @team.destroy
    respond_with @team, :location => admin_season_partition_path(@season, @partition)
  end
  
  def edit_multiple
    respond_with @standings = TeamStanding.where("partition_id = ?", @partition.id)
  end
  
  def update_multiple
    standings_params = params[:standings]
    
    @standings = TeamStanding.update standings_params.keys, standings_params.values
    standing_with_error = @standings.detect {|s| !s.errors.empty?}
    if standing_with_error == nil
      flash.notice = "Sarjataulukko päivitetty."
      respond_with @standings, :location => edit_multiple_admin_team_standing
    else
      flash.alert = "Sarjataulukko päivitetty vain osittain, koska joissain kentissä on virheitä."
      render :edit_multiple
    end
  end
  
  def latest
    begin
      latest_partition = Partition.latest selected_section
      redirect_to edit_multiple_admin_season_partition_team_standings_path(latest_partition.season, latest_partition)
    rescue
      redirect_to admin_seasons_path
    end
  end
  
  private
  
  def get_season_and_partition
    @season = Season.find params[:season_id]
    @partition = Partition.find params[:partition_id]
  end
end
