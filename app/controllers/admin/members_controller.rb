# coding: utf-8

class Admin::MembersController < Admin::BaseController
  respond_to :html
  before_filter :get_questions, :only => [:new, :create, :edit, :update]
  
  def index
    respond_with @members = Member.all
  end
  
  def new
    respond_with @member = Member.new(:questions => [])
  end
  
  def create
    @member = Member.new(params[:member])
    flash[:notice] = "Uusi pelaaja luotu." if @member.save
    respond_with @member, :location => admin_members_url
  end
  
  def edit
    respond_with @member = Member.find(params[:id])
  end
  
  def update
    @member = Member.find(params[:id])
    flash[:notice] = 'Päivitetty.' if @member.update_attributes(params[:member])
    respond_with @member, :location => admin_members_url
  end
  
  def get_questions
    @questions = Question.unique
  end
end