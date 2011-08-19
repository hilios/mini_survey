class QuestionOption < ActiveRecord::Base
  belongs_to  :question
  has_many    :answers
  
  validates   :question,
    :presence => true,
    :associated => true
  
  validates   :title,
    :presence => true,
    :length => { :minimum => 3 }
end
