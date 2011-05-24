namespace :team_standings_rank do
  desc "Calculates and updates rank for TeamStandings"
  task :calculate => :environment do
    Partition.includes(:team_standings)
      .order("2 * team_standings.wins + team_standings.overtimes DESC, team_standings.goals_for - team_standings.goals_against DESC")
      .each do |partition|
      
      rank = 1
      partition.team_standings.each do |standing|
        standing.rank = rank
        standing.save!
        rank += 1
      end
    end
  end
end
