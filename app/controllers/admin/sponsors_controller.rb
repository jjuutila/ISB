# coding: utf-8
class Admin::SponsorsController < Admin::BaseController
  respond_to :html, :except => :positions
  respond_to :js, :only => :positions
  
  def index
    respond_with @sponsors = Sponsor.all
  end

  def new
    respond_with @sponsor = Sponsor.new
  end

  def edit
    @sponsor = Sponsor.find(params[:id])
  end

  def create
    @sponsor = Sponsor.new(params[:sponsor])
    flash[:notice] = "Uusi sponsori lisätty." if @sponsor.save
    respond_with @sponsor, :location => admin_sponsors_path()
  end

  def update
    @sponsor = Sponsor.find(params[:id])
    flash[:notice] = "Sponsorin muokkaus onnistui." if @sponsor.update_attributes(params[:sponsor])
    respond_with @sponsor, :location => admin_sponsors_path()
  end

  def destroy
    @sponsor = Sponsor.find(params[:id])
    @sponsor.destroy
    respond_with @sponsor, :location => admin_sponsors_path()
  end
  
  def positions
    begin
      Sponsor.set_positions params[:positions]
      render :nothing => true, :status => :accepted
    rescue ArgumentError
      logger.error "Invalid arguments in Sponsor.set_positions"
      render :nothing => true, :status => :internal_server_error
    rescue Exception => e
      logger.error "Unknown error #{e.message}"
      render :nothing => true, :status => :internal_server_error
    end
  end
end
