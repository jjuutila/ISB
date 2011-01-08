# coding: utf-8
class Admin::TeamStandingsController < Admin::BaseController
  respond_to :html

  # GET /admin/team_standinds/new
  # GET /admin/team_standinds/new.xml
  def new
    respond_with @team = TeamStanding.new
  end

  # GET /admin/team_standinds/1/edit
  def edit
    @admin_team_standind = TeamStanding.find(params[:id])
  end

  # POST /admin/team_standinds
  # POST /admin/team_standinds.xml
  def create
    @admin_team_standind = TeamStanding.new(params[:admin_team_standind])

    respond_to do |format|
      if @admin_team_standind.save
        format.html { redirect_to(@admin_team_standind, :notice => 'Team standind was successfully created.') }
        format.xml  { render :xml => @admin_team_standind, :status => :created, :location => @admin_team_standind }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @admin_team_standind.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin/team_standinds/1
  # PUT /admin/team_standinds/1.xml
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

  # DELETE /admin/team_standinds/1
  # DELETE /admin/team_standinds/1.xml
  def destroy
    @admin_team_standind = TeamStanding.find(params[:id])
    @admin_team_standind.destroy

    respond_to do |format|
      format.html { redirect_to(admin_team_standinds_url) }
      format.xml  { head :ok }
    end
  end
  
  def edit_multiple
    respond_with @standings = TeamStanding.all
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
end
