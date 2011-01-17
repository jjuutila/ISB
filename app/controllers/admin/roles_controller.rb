# coding: utf-8
class Admin::RolesController < Admin::BaseController
  respond_to :html
  
  def index
    @all_members = Member.all
    @season = Season.find(params[:season_id])
    @players = Member.players.in_season @season
    
    respond_with @all_members
  end

end
