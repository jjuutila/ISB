# coding: utf-8

class Admin::MembersController < Admin::BaseController
  respond_to :html
  
  def index
    @members = Member.all
    respond_with @member
  end
  
  def new
    respond_with(@member = Member.new)
  end
  
  def create
    @member = Member.create(params[:member])
    flash[:notice] = "Uusi pelaaja luotu." unless @member.new_record?
    respond_with(@member, :location => admin_members_url)
  end
  
  def edit
    respond_with @member = Member.find(params[:id])
  end
end