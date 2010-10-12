class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.string :title
      t.text :content
      t.string :state
      t.references :commentable, :polymorphic => true
      t.string :author
      t.string :email
      t.string :ip_addr

      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
