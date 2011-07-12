class AddVisibilityToSection < ActiveRecord::Migration
  def self.up
    add_column :sections, :is_visible, :bool, {:default => :false}
  end

  def self.down
    remove_column :sections, :is_visible
  end
end
