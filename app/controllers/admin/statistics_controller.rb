# coding: utf-8
class Admin::StatisticsController < Admin::BaseController
  respond_to :html
  before_filter :get_partition, :except => [:latest, :edit_all_time_statistics, :update_all_time_statistics, :latest_all_time]
  
  def edit_multiple
    respond_with @statistics = Statistic.where("partition_id = ?", @partition.id)
  end
  
  def update_multiple
    statistics_params = params[:statistics]
    
    begin
      @statistics = Statistic.update statistics_params.keys, statistics_params.values
    rescue
      flash.alert = "Pistepörssi päivitetty vain osittain, koska joitain tilastoja ei löytynyt enää tietokannasta."
      redirect_to edit_multiple_admin_partition_statistics_path @partition and return
    end
    
    statistics_with_error = @statistics.find_all {|s| !s.errors.empty?}
    
    if statistics_with_error.empty?
      flash.notice = "Pistepörssi päivitetty."
      redirect_to admin_partition_path @partition
    else
      flash.alert = "Pistepörssi päivitetty vain osittain, koska joissain kentissä on virheitä."
      render :edit_multiple
    end
  end
  
  def latest
    begin
      latest_partition = Partition.latest selected_section
      redirect_to edit_multiple_admin_partition_statistics_path(latest_partition)
    rescue
      redirect_to admin_seasons_path
    end
  end
  
  def edit_all_time_statistics
    @season = Season.find params[:id]
    @players = Member.with_role_in_season("player", @season)
  end
  
  def update_all_time_statistics
    all_time_params = params[:all_time_statistics]
    @season = Season.find params[:id]
    
    begin
      @players = Member.update all_time_params.keys, all_time_params.values
      players_with_error = @players.find_all {|s| !s.errors.empty?}
    
      if players_with_error.empty?
        flash.notice = "All-Time pistepörssi päivitetty."
        redirect_to admin_season_path @season
      else
        flash.alert = "All-Time pistepörssi päivitettiin vain osittain, koska joissain kentissä on virheitä."
        render :edit_all_time_statistics
      end
    rescue ActiveRecord::RecordNotFound
      flash.alert = "All-Time pistepörssi päivitettiin vain osittain, koska joitain pelaajia ei löytynyt tietokannasta."
      redirect_to alltime_statistics_admin_season_path @season
    end
  end
  
  def latest_all_time
    begin
      latest_season = Season.latest selected_section
      redirect_to alltime_statistics_admin_season_path(latest_season)
    rescue
      redirect_to admin_seasons_path
    end
  end
  
  private
  
  def get_partition
    @partition = Partition.find params[:partition_id]
  end
end
