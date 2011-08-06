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
    @admin_section = Section.new(params[:section])

    respond_to do |format|
      if @admin_section.save
        format.html { redirect_to(admin_sections_path(), :notice => 'Section was successfully created.') }
        format.xml  { render :xml => @admin_section, :status => :created, :location => @admin_section }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @admin_section.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @admin_section = Section.find(params[:id])

    respond_to do |format|
      if @admin_section.update_attributes(params[:section])
        format.html { redirect_to(admin_sections_path(), :notice => 'Section was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @admin_section.errors, :status => :unprocessable_entity }
      end
    end
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
