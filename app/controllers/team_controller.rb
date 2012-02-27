# coding: utf-8
class TeamController < MainSiteController
  respond_to :html

  def index
    begin
      @season = Season.latest @section
      @players = Member.with_role_in_season("player", @season)
      @coaches = Member.with_role("coach").in_season @season
      @assistants = Member.with_role("assistant").in_season @season
    rescue ActiveRecord::RecordNotFound
      logger.error "Latest Season not found from #{@section}."
      @players = []
      @coaches = []
      @assistants = []
    end
  end

  def show
    respond_with @member = Member.find(params[:id]) 
  end
end
