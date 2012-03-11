# coding: utf-8
class ApplicationController < ActionController::Base
  before_filter :set_section_groups
  
  private

  def set_section_groups
    @section_groups = SectionGroup.visible
  end
end
