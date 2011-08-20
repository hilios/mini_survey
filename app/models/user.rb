class User < ActiveRecord::Base
  has_secure_password
  
  has_many :surveys
  has_many :answers
  has_and_belongs_to_many :watches, 
    :join_table => :user_watches_surveys
  
  attr_protected :last_login
  
  mount_uploader :avatar, AvatarUploader
  
  scope :that_answered_survey, lambda { |survey| select("DISTINCT(users.id)").joins(:answers).where('answers.survey_id = ?', survey.is_a?(Survey) ? survey.id : survey) }
  
  validates :password, 
    :length => { :minimum => 3 },
    :unless => Proc.new { |user| user.password.blank? }
    
  validates :password,
    :presence => true,
    :on => :create
  
  validates :name,
    :presence => true
    
  validates :email,
    :presence => true,
    :uniqueness => { :case_sensitive => false },
    :email_format => true

  validates_integrity_of  :avatar
  validates_processing_of :avatar
  
  def authenticate(*args, &block)
    self.update_attribute :last_login, Time.now
    super(*args, &block)
  end
end
