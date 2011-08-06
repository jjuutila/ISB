# coding: utf-8
class Admin::SectionsController < Admin::BaseController
  respond_to :html
  
  def index
    respond_with @sections = Section.all
  end

  def show
    respond_with @section = Section.find(params[:id])
  end

  def new
    respond_with @section = Section.new
  end

  def edit
    respond_with @section = Section.find(params[:id])
  end

  def create
    @section = Section.new(params[:section])
    flash.notice = 'Uusi joukkueosio lisätty.' if @section.save
    respond_with @section, :location => admin_sections_path
  end

  def update
    @section = Section.find(params[:id])
    flash[:notice] = 'Joukkueosio päivitetty.' if @section.update_attributes(params[:section])
    respond_with @section, :location => admin_sections_path()
  end
  
  def edit_contact
    respond_with @section = Section.find(params[:id])
  end
  
  def update_contact
    @section = Section.find(params[:id])
    if @section.update_attributes(params[:section])
      flash[:notice] = "Yhteystiedot päivitetty." 
      redirect_to admin_sections_path
    else
      render "edit_contact"
    end
  end
end
