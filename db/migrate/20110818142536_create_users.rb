class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string    :name
      t.string    :email
      t.string    :password_digest
      t.datetime  :last_login
      t.timestamps
    end
    add_index :users, :email
  end
end
