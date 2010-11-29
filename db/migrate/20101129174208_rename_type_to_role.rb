class RenameTypeToRole < ActiveRecord::Migration
  def self.up
    rename_column :affairs, :type, :role
  end

  def self.down
    rename_column :affairs, :role, :type
  end
end
