class Choice < ActiveRecord::Base
  belongs_to  :question
  
  has_many    :answers
  
  validates   :title,
    :presence => true,
    :length => { :minimum => 3 }
    
  def total
    self.answers.count
  end
  
  def to_p
    self.question.total > 0 ? self.total.to_f / self.question.total.to_f : 0.0
  end
end
