# coding: utf-8
class ApplicationController < ActionController::Base
  before_filter :set_section_groups, :meta_defaults

  def add_title(title)
    @meta_title = title + ' - Ilmajoen Salibandy'
  end
  
  private

  def set_section_groups
    @section_groups = SectionGroup.visible
  end

  def meta_defaults
    @meta_title = 'Ilmajoen Salibandy'
    @meta_description = "Sähäkkää salibandyä Ilmajoelta"
  end
end
