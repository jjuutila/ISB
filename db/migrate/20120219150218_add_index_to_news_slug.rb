class AddIndexToNewsSlug < ActiveRecord::Migration
  def change
    # Note that slug column cannot have duplicate values when migrating
    add_index :news, :slug, :unique => true
  end
end
