class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.integer :user_id
      t.string  :title
      t.boolean :is_private,  :default => false
      t.timestamps
    end
    add_index :surveys, :user_id, :unique => false
  end
end
