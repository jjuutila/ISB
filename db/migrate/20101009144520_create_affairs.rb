class CreateAffairs < ActiveRecord::Migration
  def self.up
    create_table :affairs do |t|
      t.string :type
      t.references :member
      t.references :season
    end
  end

  def self.down
    drop_table :affairs
  end
end
