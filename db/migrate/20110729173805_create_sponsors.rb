class CreateSponsors < ActiveRecord::Migration
  def self.up
    create_table :sponsors do |t|
      t.string    :name
      t.string    :url
      t.integer   :position
      
      t.string    :logo_file_name
      t.string    :logo_content_type
      t.integer   :logo_file_size
      t.datetime  :logo_updated_at
      t.integer   :logo_width
      t.integer   :logo_height

      t.timestamps
    end
  end

  def self.down
    drop_table :sponsors
  end
end
