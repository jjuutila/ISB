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
  
  def matches
    @partition = Partition.latest @section
    respond_with @matches = Match.where(:partition_id => @partition.id)
  end
  
  def show_match
    respond_with @match = Match.find(params[:id])
  end
end