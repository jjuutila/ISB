# coding: utf-8
class Admin::StatisticsController < Admin::BaseController
  respond_to :html
  before_filter :get_season_and_partition
  
  def edit_multiple
    respond_with @statistics = Statistic.where("partition_id = ?", @partition.id)
  end
  
  def update_multiple
    statistics_params = params[:statistics]
    
    begin
      @statistics = Statistic.update statistics_params.keys, statistics_params.values
    rescue
      flash.alert = "Pistepörssi päivitetty vain osittain, koska joitain tilastoja ei löytynyt enää tietokannasta."
      redirect_to edit_multiple_admin_season_partition_statistics_path @season, @partition and return
    end
    
    statistics_with_error = @statistics.find_all {|s| !s.errors.empty?}
    
    if statistics_with_error.empty?
      flash.notice = "Pistepörssi päivitetty."
      redirect_to admin_season_partition_path @season, @partition
    else
      flash.alert = "Pistepörssi päivitetty vain osittain, koska joissain kentissä on virheitä."
      render :edit_multiple
    end
  end
  
  def get_season_and_partition
    @season = Season.find params[:season_id]
    @partition = Partition.find params[:partition_id]
  end
end
