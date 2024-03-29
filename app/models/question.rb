class Question < ActiveRecord::Base
  belongs_to    :survey
  
  has_many      :choices,
    :dependent => :destroy
    
  has_many      :answers,
    :dependent => :destroy
  
  accepts_nested_attributes_for :choices, 
    :allow_destroy => true,
    :reject_if => lambda { |choice| choice[:title].blank? }
  
  scope :from_survey, lambda { |survey| joins(:survey).where('questions.survey_id = ?', survey.is_a?(Survey) ? survey.id : survey) }
  
  validates :title,
    :presence => true
  
  def total
    self.answers.count
  end
end
