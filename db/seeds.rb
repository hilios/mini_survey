# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

User.create(:name => 'Edson Hilios', :email => 'edson.hilios@gmail.com', :password => '1qaz', :password_confirmation => '1qaz').save!
