module SectionHelper
  def section_link_list_for sections
    section_links = sections.collect { |s| link_to s.name, section_news_path(s.slug) }
    section_links.to_sentence(:two_words_connector => " ja ", :last_word_connector => ", ja ").html_safe
  end
end
