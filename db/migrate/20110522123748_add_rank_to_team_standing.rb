class AddRankToTeamStanding < ActiveRecord::Migration
  def self.up
    add_column :team_standings, :rank, :integer
    say "Calculating ranks for team standings"
    Rake::Task["team_standings_rank:calculate"].invoke
  end

  def self.down
    remove_column :team_standings, :rank
  end
end
