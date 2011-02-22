# coding: utf-8
class SectionController < ApplicationController
  respond_to :html
  before_filter :get_section
  
  def get_section
    @section = Section.find_by_slug params[:section]
  end
  
  def news
    respond_with @news = News.in_section(@section)
  end
end