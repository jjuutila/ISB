# coding: utf-8
class Admin::LinkCategoriesController < Admin::BaseController
  respond_to :html
  
  def index
    respond_with @link_categories = LinkCategory.in_section(selected_section)
  end

  def show
    respond_with @link_category = LinkCategory.find(params[:id])
  end

  def new
    @selected_section = selected_section
    respond_with @link_category = LinkCategory.new
  end

  def edit
    respond_with @link_category = LinkCategory.find(params[:id])
  end

  def create
    @link_category = selected_section.link_categories.build(params[:link_category])
    
    flash.notice = 'Uusi linkkikategoria luotu.' if @link_category.save
    
    respond_with @link_category, :location => admin_link_category_path(@link_category)
  end

  def update
    @link_category = LinkCategory.find(params[:id])
    
    flash.notice = 'Linkkikategoria päivitetty.' if @link_category.update_attributes(params[:link_category])
    
    respond_with @link_category, :location => admin_link_category_path(@link_category)
  end

  def destroy
    @link_category = LinkCategory.find(params[:id])
    @link_category.destroy
    respond_with @link_category, :location => admin_link_categories_path
  end
end
