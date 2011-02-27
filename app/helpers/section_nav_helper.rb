module SectionNavHelper
  def create_menu_item(name, action)
    link_to_unless current_page?(:controller => :section, :action => action), name,
      {:section => @section.slug, :controller => :section, :action => action }
  end
end



