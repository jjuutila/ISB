# coding: utf-8

class Admin::PartitionsController < Admin::BaseController
  respond_to :html
  
  def show
    respond_with @partition = Partition.find(params[:id], :include => [:season, :team_standings])
  end
  
  def new
    respond_with @partition = Partition.new(:season_id => params[:season_id])
  end
  
  def edit
    respond_with @partition = Partition.find(params[:id])
  end
  
  def create
    begin
      @season = Season.find params[:season_id]
    rescue ActiveRecord::RecordNotFound
      redirect_to admin_seasons_path and return
    end
    
    @partition = @season.partitions.build params[:partition]
    
    respond_to do |format|
      if @partition.save
        format.html { redirect_to(admin_season_partition_path(@season, @partition), 
          :notice => 'Uusi kausiosio luotu.') }
      else
        format.html { render :action => "new" }
      end
    end
  end
  
  def update
    @partition = Partition.find(params[:id])
    
    respond_to do |format|
      if @partition.update_attributes(params[:partition])
        format.html { redirect_to(admin_season_partition_path(@partition.season, @partition), :notice => 'Kausiosio päivitetty.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end
  
  def destroy
    @partition = Partition.find(params[:id])
    @partition.destroy
    respond_to do |format|
      format.html { redirect_to(admin_seasons_url) }
    end
  end
end
