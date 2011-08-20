class CreateUserWatchesSurveys < ActiveRecord::Migration
  def change
    create_table :user_watches_surveys, :id => false do |t|
      t.integer :user_id
      t.integer :survey_id
    end
    add_index :user_watches_surveys, :user_id,    :unique => false
    add_index :user_watches_surveys, :survey_id,  :unique => false
  end
end
