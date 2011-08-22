class Survey < ActiveRecord::Base
  belongs_to  :user
  has_many    :questions
  has_and_belongs_to_many :watches,
    :join_table => :watches, :association_foreign_key => :survey_id, :foreign_key => :user_id
  accepts_nested_attributes_for :questions, 
    :allow_destroy => true
  
  
  scope :not_private, where('surveys.is_private = ?', false)
  
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
