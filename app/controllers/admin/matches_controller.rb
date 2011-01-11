# coding: utf-8
class Admin::MatchesController < Admin::BaseController
  before_filter :get_season_and_partition
  respond_to :html

  def index
    respond_with @matches = Match.where(:partition_id => @partition.id)
  end

  def new
    respond_with @match = Match.new
  end

  def edit
    respond_with @match = Match.find(params[:id])
  end

  def create
    @match = @partition.matches.build(params[:match])
    flash[:notice] = 'Uusi ottelu luotu.' if @match.save
    respond_with @match, :location => admin_season_partition_matches_path(@season, @partition)
  end

  def update
    @match = Match.find(params[:id])
    flash[:notice] = "Ottelu '#{@match.to_s}' päivitetty." if @match.update_attributes(params[:match])
    respond_with @match, :location => admin_season_partition_matches_path(@season, @partition)
  end

  def destroy
    @match = Match.find(params[:id])
    @match.destroy
    respond_with @match, :location => admin_season_partition_matches_path(@season, @partition)
  end
  
  private
  
  def get_season_and_partition
    @season = Season.find params[:season_id]
    @partition = Partition.find params[:partition_id]
  end
end
