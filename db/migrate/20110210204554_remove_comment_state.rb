class RemoveCommentState < ActiveRecord::Migration
  def self.up
    remove_column :comments, :state
  end

  def self.down
    add_column :comments, :state
  end
end
