class CreateChoices < ActiveRecord::Migration
  def change
    create_table :choices do |t|
      t.integer :question_id
      t.text    :title
      t.timestamps
    end
    add_index :choices, :question_id, :unique => false
  end
end
