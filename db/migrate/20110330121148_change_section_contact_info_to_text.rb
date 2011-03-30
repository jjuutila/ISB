class ChangeSectionContactInfoToText < ActiveRecord::Migration
  def self.up
    change_column :sections, :contact_info, :text
  end

  def self.down
    change_column :sections, :contact_info, :string
  end
end
