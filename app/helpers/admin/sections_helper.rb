module Admin::SectionsHelper
  def section_selection
    render :partial => 'admin/section_selection', :locals => { :sections => Section.leafs }
  end
end
