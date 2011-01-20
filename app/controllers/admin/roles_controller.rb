# coding: utf-8
class Admin::RolesController < Admin::BaseController
  respond_to :html, :only => :index
  respond_to :json, :except => :index
  
  def index
    @season = Season.find(params[:season_id])
    @unassigned_members = Member.not_in_season @season
    @players = Member.players.in_season @season
    
    respond_with
  end
  
  def create
    season = Season.find(params[:season_id])
    member = Member.find(params[:id])
    
    affair = Affair.create :season => season, :member => member, :role => params[:role]
    
    #puts 'set_role called'
    respond_with affair
  end

end
