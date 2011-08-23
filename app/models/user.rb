class User < ActiveRecord::Base
  has_secure_password
  
  has_many :surveys
  
  has_many :answers
  
  has_many :watches
  
  has_and_belongs_to_many :surveys_watched,
    :join_table => :watches, :class_name => 'Survey',
    :association_foreign_key => :survey_id, :foreign_key => :user_id
  
  accepts_nested_attributes_for :answers,
    :allow_destroy => true,
    :reject_if => lambda { |answer| answer[:choice].nil? }
  
  accepts_nested_attributes_for :watches,
    :allow_destroy => true,
    :reject_if => lambda { |watch| watch[:survey].nil? }
  
  attr_protected :last_login
  
  mount_uploader :avatar, AvatarUploader
  
  scope :that_answered_survey, lambda { |survey| select("DISTINCT(users.id)").joins(:answers).where('answers.survey_id = ?', survey.is_a?(Survey) ? survey.id : survey) }
  
  validates :password, 
    :length => { :minimum => 3 },
    :unless => Proc.new { |user| user.password.blank? }
    
  validates :password,
    :presence => true,
    :on => :create
  
  validates :password_confirmation,
    :presence => true,
    :unless => Proc.new { |user| user.password.blank? }
  
  validates :name,
    :presence => true
    
  validates :email,
    :presence => true,
    :email_format => true
  
  validates :email,
    :uniqueness => { :case_sensitive => false },
    :on => :create

  validates_integrity_of  :avatar
  validates_processing_of :avatar
  
  def authenticate(*args, &block)
    self.update_attribute :last_login, Time.now
    super(*args, &block)
  end
  
  def answered_survey?(survey)
    self.answers.where('answers.survey_id = ?', survey.is_a?(Survey) ? survey.id : survey).count > 0
  end
  
  def answered_choice?(choice)
    self.answers.where('answers.choice_id = ?', choice.is_a?(Choice) ? choice.id : choice).count > 0
  end
  
  def watches?(survey)
    self.watches.where('watches.survey_id = ?', survey.is_a?(Survey) ? survey.id : survey).count > 0
  end
end
