SimpleNavigation::Configuration.run do |navigation|
  navigation.items do |primary|
    primary.item :news, 'Ajankohtaista', section_news_path(@section.slug)
    primary.item :guestbook, 'Vieraskirja', guestbook_path(@section.slug) do |guestbook|
      guestbook.item :new_guestbook_message, 'Kirjoita viesti', new_guestbook_message_path(@section.slug)
    end
    primary.item :team, 'Joukkue', team_path(@section.slug)
    primary.item :matches, 'Ottelut', latest_matches_path(@section.slug), :highlights_on => /\/ottelu/
    primary.item :statistics, 'Pistepörssi', latest_statistics_path(@section.slug), :highlights_on => /\/pisteporssi/ do |statistics|
      statistics.item :all_time, "All-Time", all_time_statistics_path(@section.slug)
    end
    primary.item :standings, 'Sarjataulukko', latest_standings_path(@section.slug), :highlights_on => /\/sarjataulukko/
    primary.item :photo_gallery, 'Kuvagalleria', albums_path(@section.slug), :highlights_on => /\/kuvagalleria/,
      :if => Proc.new { @section.picasa_user_id }
    primary.item :links, 'Linkit', links_path(@section.slug)
    primary.item :contact_info, 'Yhteystiedot', contact_info_path(@section.slug)
    primary.item :history, 'Historia', history_path(@section.slug), :highlights_on => /\/historia/
  end
end
