class AddShootsToMember < ActiveRecord::Migration
  def self.up
    add_column :members, :shoots, :string, {:limit => 5, :null => true, :default => :null}
  end

  def self.down
    remove_column :members, :shoots
  end
end
