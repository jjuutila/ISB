class AddForeignKeyIndicies < ActiveRecord::Migration
  def self.up
    add_index :seasons, :section_id
    add_index :comments, [:commentable_id, :commentable_type]
    add_index :affairs, [:season_id, :role]
    add_index :link_categories, :section_id
    add_index :links, :category_id
    add_index :matches, :partition_id
    add_index :news_sections, [:section_id, :news_id]
    add_index :partitions, :season_id
    add_index :statistics, :partition_id
    add_index :team_standings, :partition_id
  end

  def self.down
    remove_index :seasons, :column => :section_id
    remove_index :comments, :column => [:commentable_id, :commentable_type]
    remove_index :affairs, :column => [:season_id, :role]
    remove_index :link_categories, :section_id
    remove_index :links, :category_id
    remove_index :matches, :partition_id
    remove_index :news_sections, :column => [:section_id, :news_id]
    remove_index :partitions, :season_id
    remove_index :statistics, :partition_id
    remove_index :team_standings, :partition_id
  end
end
