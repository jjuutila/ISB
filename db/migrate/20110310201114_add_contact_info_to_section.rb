class AddContactInfoToSection < ActiveRecord::Migration
  def self.up
    add_column :sections, :contact_info, :string
  end

  def self.down
    remove_column :sections, :contact_info
  end
end
