namespace :team_standings_rank do
  desc "Calculates and updates rank for TeamStandings"
  task :calculate => :environment do
    Partition.transaction do
      Partition.all.each do |partition|
        rank = 1
        puts "#{partition.id}: #{partition}"
        
        # Need to use unscoped here because of default_scope in TeamStanding
        TeamStanding.unscoped.where(:partition_id => partition.id)
          .order("(2 * team_standings.wins + team_standings.overtimes) DESC, (team_standings.goals_for - team_standings.goals_against) DESC")
          .each do |standing|
          
          puts "#{rank}. #{standing.points}"
          standing.rank = rank
          standing.save!
          rank += 1
        end
      end
    end
  end
end
