class AddPicasaUserIdToSections < ActiveRecord::Migration
  def self.up
    add_column :sections, :picasa_user_id, :string
  end

  def self.down
    remove_column :sections, :picasa_user_id
  end
end
