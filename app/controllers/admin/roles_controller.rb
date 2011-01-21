# coding: utf-8
class Admin::RolesController < Admin::BaseController
  respond_to :html, :only => :index
  respond_to :js, :except => :index
  
  def index
    @season = Season.find(params[:season_id])
    @unassigned_members = Member.not_in_season @season
    @players = Member.players.in_season @season
    
    respond_with
  end
  
  def create
    season = Season.find(params[:season_id])
    member = Member.find(params[:member_id])
    
    affair = Affair.new :season => season, :member => member, :role => params[:role]
    
    if affair.save
     render :nothing => true, :status => :created 
    else
     render :nothing => true, :status => :not_acceptable
    end
  end
end