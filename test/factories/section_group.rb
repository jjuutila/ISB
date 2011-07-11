Factory.define :section_group do |g|
  g.name {Faker::Lorem.words(2).join(" ")}
  g.slug {Faker::Lorem.words(2).join("-").downcase}
  g.are_players_male true
end
