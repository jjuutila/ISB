module GlobalMenuHelper
  def generate_global_menu_items
    menu_items = [{ :key => :front_page, :name => 'Etusivu', :url => '/',
      :options => { :highlights_on => Regexp.new("(\/$|\/uutiset\/)") } }]
    
    @section_groups.each do |group|
      menu_items.push({
        :key => group.slug,
        :name => group.name,
        :url => section_news_path(group.first_sections_slug),
        :options => { :highlights_on => Regexp.new("\/#{group.first_sections_slug}") },
        :items => get_sub_menu_items_for(group)
      })
    end

    menu_items
  end
  
  def get_sub_menu_items_for(group)
    group.sections.collect { |s| {
      :key => s.slug,
      :name => s.name,
      :url => section_news_path(s.slug),
      :options => { :highlights_on => Regexp.new("\/#{s.slug}/") }
      } }
  end
end
