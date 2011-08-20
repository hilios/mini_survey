class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.integer :question_option_id
      t.integer :user_id
      t.integer :survey_id
      t.text    :title
      t.timestamps
    end
    add_index   :answers, :question_option_id,  :unique => false
    add_index   :answers, :user_id,             :unique => false
    add_index   :answers, :survey_id,           :unique => false
  end
end
