# coding: utf-8
class Admin::RolesController < Admin::BaseController
  respond_to :html, :only => :index
  respond_to :js, :except => :index
  
  def index
    @season = Season.find(params[:season_id])
    @unassigned_members = Member.not_in_season @season
    @players = Member.with_role("player").in_season @season
    @coaches = Member.with_role("coach").in_season @season
    
    respond_with
  end
  
  def create
    season = Season.find(params[:season_id])
    member = Member.find(params[:id])
    
    affair = Affair.new :season => season, :member => member, :role => params[:data][:role]
    
    if affair.save
     render :nothing => true, :status => :created 
    else
     render :nothing => true, :status => :not_acceptable
    end
  end
  
  def update
    begin
      affair = find_affair
    
      if affair.update_attributes(params[:data])
       render :nothing => true, :status => :accepted 
      else
       render :nothing => true, :status => :not_acceptable
      end
    rescue
        render :nothing => true, :status => :not_found
    end
  end
  
  def destroy
    begin
      affair = find_affair
      
      if affair.destroy
        render :nothing => true, :status => :accepted 
      else
        render :nothing => true, :status => :not_acceptable
      end
    rescue
      render :nothing => true, :status => :not_found
    end
  end
  
  def current_team
    begin
      latest_season = Season.latest selected_section
      redirect_to admin_season_roles_path latest_season
    rescue
      redirect_to admin_seasons_path
    end
  end
  
  private
  
  def find_affair
      season = Season.find(params[:season_id])
      member = Member.find(params[:id])
      Affair.find_by_season_id_and_member_id!(season.id, member.id)
  end
end
