Given /^the following standings:$/ do |team_standings|
  TeamStanding.create!(team_standings.hashes)
end

When /^I delete the (\d+)(?:st|nd|rd|th) standing$/ do |pos|
  visit team_standings_path
  within("table tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end

Then /^I should see the following standings:$/ do |expected_team_standings_table|
  expected_team_standings_table.diff!(tableish('table tr', 'td,th'))
end
