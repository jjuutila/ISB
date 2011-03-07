# coding: utf-8
class Admin::BaseController < ActionController::Base
  before_filter :set_locale
  protect_from_forgery
  layout 'admin/application'
  
  def set_locale
    I18n.locale = :fi
  end
  
  def selected_section 
    @selected_section ||= session[:selected_section] && Section.find(session[:selected_section])
    @selected_section ||= Section.leafs.first
    
    if !@selected_section
      throw "No sections in the database."
    end
    return @selected_section
  end
  
  def set_selected_section(section)
    session[:selected_section] = section
  end
  
  def change_section
  	selected_section_id = params[:selected_section][:id]
  	set_selected_section Section.find(selected_section_id)
  	redirect_to :back
  end
end