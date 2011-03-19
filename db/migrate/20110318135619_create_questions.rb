class CreateQuestions < ActiveRecord::Migration
  def self.up
    create_table :questions do |t|
      t.string :content
      t.string :answer
      t.references :member

      t.timestamps
    end
    
    add_index :questions, :member_id
  end

  def self.down
    drop_table :questions
  end
end
