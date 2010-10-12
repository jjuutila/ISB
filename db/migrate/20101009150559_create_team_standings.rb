class CreateTeamStandings < ActiveRecord::Migration
  def self.up
    create_table :team_standings do |t|
      t.string :name
      t.references :partition
      t.integer :wins
      t.integer :losses
      t.integer :overtimes
      t.integer :goals_for
      t.integer :goals_against

      t.timestamps
    end
  end

  def self.down
    drop_table :team_standings
  end
end
