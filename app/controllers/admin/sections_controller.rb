class Admin::SectionsController < ApplicationController
  # GET /admin/sections
  # GET /admin/sections.xml
  def index
    @admin_sections = Admin::Section.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @admin_sections }
    end
  end

  # GET /admin/sections/1
  # GET /admin/sections/1.xml
  def show
    @admin_section = Admin::Section.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @admin_section }
    end
  end

  # GET /admin/sections/new
  # GET /admin/sections/new.xml
  def new
    @admin_section = Admin::Section.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @admin_section }
    end
  end

  # GET /admin/sections/1/edit
  def edit
    @admin_section = Admin::Section.find(params[:id])
  end

  # POST /admin/sections
  # POST /admin/sections.xml
  def create
    @admin_section = Admin::Section.new(params[:section])

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

  # PUT /admin/sections/1
  # PUT /admin/sections/1.xml
  def update
    @admin_section = Admin::Section.find(params[:id])

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

  # DELETE /admin/sections/1
  # DELETE /admin/sections/1.xml
  def destroy
    @admin_section = Admin::Section.find(params[:id])
    @admin_section.destroy

    respond_to do |format|
      format.html { redirect_to(admin_sections_url) }
      format.xml  { head :ok }
    end
  end
end
