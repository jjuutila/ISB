# coding: utf-8
class Admin::LinkCategoriesController < Admin::BaseController
  respond_to :html
  
  def index
    respond_with @link_categories = LinkCategory.all
  end

  def show
    respond_with @link_category = LinkCategory.find(params[:id])
  end

  def new
    respond_with @link_category = LinkCategory.new
  end

  def edit
    respond_with @link_category = LinkCategory.find(params[:id])
  end

  def create
    @link_category = LinkCategory.new(params[:link_category])
    
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
