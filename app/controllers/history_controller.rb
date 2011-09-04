# coding: utf-8
class HistoryController < MainSiteController
  respond_to :html
  
  def index
    respond_with @seasons = Season.all_except_newest(@section)
  end
  
  def show
    respond_with @season = Season.includes(:partitions => [:matches, :team_standings, :statistics_with_matches])
      .find_by_start_year_and_section_id!(params[:year], @section.id)
  end
end
