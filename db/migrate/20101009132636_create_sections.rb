class CreateSections < ActiveRecord::Migration
  def self.up
    create_table :sections do |t|
      t.string :slug
      t.references :parent
      t.string :name
    end
  end

  def self.down
    drop_table :sections
  end
end
