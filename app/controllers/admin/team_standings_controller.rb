# coding: utf-8
class Admin::TeamStandingsController < Admin::BaseController
  # GET /admin/team_standinds
  # GET /admin/team_standinds.xml
  def index
    @admin_team_standings = Admin::TeamStanding.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @admin_team_standings }
    end
  end

  # GET /admin/team_standinds/1
  # GET /admin/team_standinds/1.xml
  def show
    @admin_team_standind = Admin::TeamStanding.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @admin_team_standind }
    end
  end

  # GET /admin/team_standinds/new
  # GET /admin/team_standinds/new.xml
  def new
    @admin_team_standind = Admin::TeamStanding.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @admin_team_standind }
    end
  end

  # GET /admin/team_standinds/1/edit
  def edit
    @admin_team_standind = Admin::TeamStanding.find(params[:id])
  end

  # POST /admin/team_standinds
  # POST /admin/team_standinds.xml
  def create
    @admin_team_standind = Admin::TeamStanding.new(params[:admin_team_standind])

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
    @admin_team_standind = Admin::TeamStanding.find(params[:id])

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
    @admin_team_standind = Admin::TeamStanding.find(params[:id])
    @admin_team_standind.destroy

    respond_to do |format|
      format.html { redirect_to(admin_team_standinds_url) }
      format.xml  { head :ok }
    end
  end
  
  def edit_multiple
    @counter = 0
    @admin_team_standings = Admin::TeamStanding.all
    respond_to do |format|
      format.html
    end
  end
  
  
end
