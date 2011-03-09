# coding: utf-8
class SectionController < ApplicationController
  respond_to :html
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
  
  def guestbook
    respond_with @messages = Comment.messages(@section, params[:page])
  end
  
  def new_guestbook_message
    respond_with @message = Comment.new
  end
  
  def create_guestbook_message
    @message = @section.comments.build params[:comment]
    if @message.save
      redirect_to guestbook_path(@section.slug)
    else
      render "section/new_guestbook_message"
    end
  end
  
  def links
    respond_with @link_categories = LinkCategory.in_section(@section)
  end
  
  def statistics
    begin
      @partition = Partition.latest @section
      @statistics = Statistic.in_partition @partition
    rescue ActiveRecord::RecordNotFound
      @statistics = []
    end
    respond_with @statistics
  end
end