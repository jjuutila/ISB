# coding: utf-8
class MainSiteController < ApplicationController
  before_filter :get_section_or_404
  
  def get_section_or_404
    @section = Section.find_by_slug params[:section]
    render_404 if @section.nil?
  end
  
  def render_404
    respond_to do |format|
      format.html { render :file => "#{Rails.root}/public/404.html", :layout => false, :status => :not_found }
      format.any  { head :not_found }
    end
  end
end
