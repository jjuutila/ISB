class CreatePartitions < ActiveRecord::Migration
  def self.up
    create_table :partitions do |t|
      t.string :name
      t.references :season
      t.integer :position

      t.timestamps
    end
  end

  def self.down
    drop_table :partitions
  end
end
