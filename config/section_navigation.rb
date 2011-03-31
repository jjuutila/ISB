SimpleNavigation::Configuration.run do |navigation|
  navigation.items do |primary|
    primary.item :news, 'Ajankohtaista', section_news_path(@section.slug)
    primary.item :guestbook, 'Vieraskirja', guestbook_path(@section.slug) do |guestbook|
      guestbook.item :new_guestbook_message, 'Kirjoita viesti', new_guestbook_message_path(@section.slug)
    end
    primary.item :team, 'Joukkue', team_path(@section.slug)
    primary.item :matches, 'Ottelut', matches_path(@section.slug)
    primary.item :statistics, 'Pistepörssi', statistics_path(@section.slug)
    primary.item :standings, 'Sarjataulukko', standings_path(@section.slug)
    primary.item :links, 'Linkit', links_path(@section.slug)
    primary.item :contact_info, 'Yhteystiedot', contact_info_path(@section.slug)
  end
end