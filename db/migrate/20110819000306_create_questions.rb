class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.integer :survey_id
      t.text    :title
      t.timestamps
    end
    add_index :questions, :survey_id, :unique => false
  end
end
