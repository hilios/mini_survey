class CreateQuestionOptions < ActiveRecord::Migration
  def change
    create_table :question_options do |t|
      t.integer :question_id
      t.text    :title
      t.timestamps
    end
    add_index :question_options, :question_id, :unique => false
  end
end
