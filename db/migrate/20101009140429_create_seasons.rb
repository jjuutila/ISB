class CreateSeasons < ActiveRecord::Migration
  def self.up
    create_table :seasons do |t|
      t.string :division
      t.text :history
      t.string :state
      t.references :section
      t.integer :start_year

      t.timestamps
    end
  end

  def self.down
    drop_table :seasons
  end
end
