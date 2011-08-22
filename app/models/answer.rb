class Answer < ActiveRecord::Base
  belongs_to      :user
  belongs_to      :survey
  belongs_to      :choice
  belongs_to      :question
  
  attr_protected  :survey, :question
  
  scope :from_question, Proc.new { |question| where('question_id = ?', question.is_a?(Question) ? question.id : question) }
  
  validates :user,
    :presence => true,
    :associated => true
  
  validates :choice,
    :presence => true,
    :associated => true
  
  validates :user_id,
    :uniqueness => { :scope => :choice_id }
    
  before_save :set_survey_and_question
  
  private
  
  def set_survey_and_question
    self.question = choice.question
    self.survey = choice.question.survey
  end
end
