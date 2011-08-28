Factory.define :team_standing do |f|
  f.sequence(:name) {|n| "Team #{n}" }
end