class Survey < ActiveRecord::Base
  belongs_to  :user
  
  delegate :name,
    :to => :user, :prefix => true, :allow_nil => true
  
  has_many    :questions,
    :dependent => :destroy
    
  has_and_belongs_to_many :watches,
    :join_table => :watches, :association_foreign_key => :survey_id, :foreign_key => :user_id
    
  accepts_nested_attributes_for :questions, 
    :allow_destroy => true,
    :reject_if => lambda { |question| question[:title].blank? }
  
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
    User.includes("surveys").that_answered_survey(self).count
  end
end
