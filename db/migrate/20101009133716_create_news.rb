class CreateNews < ActiveRecord::Migration
  def self.up
    create_table :news do |t|
      t.string :slug
      t.references :section
      t.string :title
      t.text :content

      t.timestamps
    end
    
    create_table :news_sections, :id => false do |t|
      t.references :news
      t.references :section 
    end
  
  end

  def self.down
    drop_table :news
  end
end
