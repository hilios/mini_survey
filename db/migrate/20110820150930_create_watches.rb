class CreateWatches < ActiveRecord::Migration
  def change
    create_table :watches, :id => false do |t|
      t.integer :user_id
      t.integer :survey_id
    end
    add_index :watches, :user_id,    :unique => false
    add_index :watches, :survey_id,  :unique => false
  end
end
