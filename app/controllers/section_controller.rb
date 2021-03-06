# coding: utf-8
class SectionController < MainSiteController
  respond_to :html
  
  def latest_matches
    get_latest_partition_or_nil
    render :action => 'matches'
  end
  
  def show_matches
    @partition = Partition.find(params[:id])
    render :action => 'matches'
  end
  
  def show_match
    respond_with @match = Match.find(params[:id])
  end
  
  def guestbook
    respond_with @messages = Comment.messages(@section, params[:sivu])
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
  
  def latest_statistics
    get_latest_partition_or_nil
    render :action => 'statistics'
  end
  
  def show_statistics
    @partition = Partition.find(params[:id])
    render :action => 'statistics'
  end
  
  def latest_standings
    get_latest_partition_or_nil
    render :action => 'standings'
  end
  
  def show_standings
    @partition = Partition.find(params[:id])
    render :action => 'standings'
  end
  
  def contact_info
    respond_with
  end
  
  def all_time_statistics
    respond_with @players = Member.players_with_points_in_any_season(@section.group.are_players_male)
  end
  
  private
  
  def get_latest_partition_or_nil
    begin
      @partition = Partition.latest @section
    rescue ActiveRecord::RecordNotFound
      logger.error "Latest Partition not found from #{@section}."
      @partition = nil
    end
  end
end
