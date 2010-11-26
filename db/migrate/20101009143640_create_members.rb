class CreateMembers < ActiveRecord::Migration
  def self.up
    create_table :members do |t|
      t.integer :number
      t.string :first_name
      t.string :last_name
      t.boolean :gender
      t.integer :position
      t.integer :birth_year
      t.string :home_municipality
      t.integer :all_time_assists, :null => false, :default => 0
      t.integer :all_time_goals, :null => false, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :members
  end
end
