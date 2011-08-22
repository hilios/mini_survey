class Choice < ActiveRecord::Base
  belongs_to  :question
  has_many    :answers
  
  accepts_nested_attributes_for :answers, 
    :allow_destroy => true
  
  validates   :question,
    :presence => true,
    :associated => true
  
  validates   :title,
    :presence => true,
    :length => { :minimum => 3 }
end
