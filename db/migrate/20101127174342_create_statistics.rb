class CreateStatistics < ActiveRecord::Migration
  def self.up
    create_table :statistics do |t|
      t.references :partition
      t.references :member
      t.integer :assists
      t.integer :goals
      t.integer :matches
      t.integer :pim

      t.timestamps
    end
  end

  def self.down
    drop_table :statistics
  end
end
