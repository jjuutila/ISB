class CreateMatches < ActiveRecord::Migration
  def self.up
    create_table :matches do |t|
      t.references :home_team
      t.references :visitor_team
      t.references :partition
      t.integer :home_goals
      t.integer :visitor_goals
      t.string :additional_info
      t.string :location
      t.datetime :start_time
      t.text :report

      t.timestamps
    end
  end

  def self.down
    drop_table :matches
  end
end
