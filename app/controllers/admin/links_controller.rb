# coding: utf-8
class Admin::LinksController < Admin::BaseController
  respond_to :html
  before_filter :find_category
  
  def new
    respond_with @link = Link.new
  end

  def edit
    respond_with @link = Link.find(params[:id])
  end

  def create
    @link = Link.new(params[:link])
    
    flash.notice = "Uusi linkki luotu" if @link.save
    
    respond_with @link, :location => admin_link_category_path(@category)
  end

  def update
    @link = Link.find(params[:id])
    
    flash.notice = "Uusi linkki luotu" if @link.update_attributes(params[:link])
    
    respond_with @link, :location => admin_link_category_path(@category)
  end

  def destroy
    @link = Link.find(params[:id])
    @link.destroy
    respond_with @link, :location => admin_link_category_path(@category)
  end
  
  def find_category
    @category = LinkCategory.find(params[:link_category_id])
  end
end
