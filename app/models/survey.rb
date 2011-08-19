class Survey < ActiveRecord::Base
  belongs_to  :user
  has_many    :questions
  
  validates   :user,
    :presence => true,
    :associated => true
  
  validates   :title,
    :presence => true,
    :length => { :minimum => 3 }
    
  def private?
    self.is_private || false
  end
end
