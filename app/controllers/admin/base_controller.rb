# coding: utf-8
class Admin::BaseController < ActionController::Base
  layout 'admin/application'
  
  def selected_section 
    @_selected_section ||= session[:selected_section] && Section.find(session[:selected_section])
    @_selected_section ||= Section.find(:first, :conditions => ["parent_id NOT NULL"])
  end
  
  def set_selected_section(section)
    session[:selected_section] = section
  end
end