# coding: utf-8
class Admin::BaseController < ActionController::Base
  layout 'admin/application'
  
  def selected_section 
    @_selected_section ||= session[:selected_section_id] &&  Section.find(session[:selected_section_id])
  end
  
  def set_selected_section(section)
    session[:selected_section_id] = section.id
  end
end