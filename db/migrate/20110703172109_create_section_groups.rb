class CreateSectionGroups < ActiveRecord::Migration
  def self.up
    # SectionGroup
    create_table :section_groups do |t|
      t.string :name
      t.boolean :are_players_male
      t.string :slug

      t.timestamps
    end
    
    # Section
    rename_column(:sections, :parent_id, :section_group_id)
    add_index :sections, :section_group_id
  end

  def self.down
    drop_table :section_groups
    
    # Section
    rename_column(:sections, :section_group_id, :parent_id)
    remove_index :sections, :section_group_id
  end
end
