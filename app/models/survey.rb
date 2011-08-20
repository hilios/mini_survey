class Survey < ActiveRecord::Base
  belongs_to  :user
  has_many    :questions
  has_and_belongs_to_many :watchers, 
    :join_table => :user_watches_surveys
  
  validates   :user,
    :presence => true,
    :associated => true
  
  validates   :title,
    :presence => true,
    :length => { :minimum => 3 }
    
  def private?
    self.is_private || false
  end
  
  def total
    User.
      select('DISTINCT(users.id)').
      that_answered_survey(self).
      count
  end
end
