# coding: utf-8
class ApplicationController < ActionController::Base
  before_filter :set_section_groups
  
  def set_section_groups
    @section_groups = SectionGroup.all
  end
end
