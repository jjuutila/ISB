# coding: utf-8
class SectionController < MainSiteController
  respond_to :html
  
  def news
    respond_with @news = News.in_section(@section, params[:page])
  end
  
  def matches
    begin
      @partition = Partition.latest @section
      @matches = Match.where(:partition_id => @partition.id)
    rescue ActiveRecord::RecordNotFound
      logger.error "Latest partition not found from #{@section}."
      @matches = []
    end
    respond_with @matches
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
  
  def team
    begin
      @season = Season.latest @section
      @players = Member.with_role("player").in_season @season
      @coaches = Member.with_role("coach").in_season @season
    rescue ActiveRecord::RecordNotFound
      logger.error "Latest Season not found from #{@section}."
      @players = []
      @coaches = []
    end
  end
  
  def standings
    begin
      @partition = Partition.latest @section
      @standings = TeamStanding.in_partition @partition
    rescue ActiveRecord::RecordNotFound
      @standings = []
    end
    respond_with @standings
  end
  
  def contact_info
    respond_with
  end
  
  def player
    respond_with @member = Member.find(params[:id]) 
  end
  
  def all_time_statistics
    respond_with @players = Member.players_with_points_in_any_season
  end
end