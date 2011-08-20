class Answer < ActiveRecord::Base
  belongs_to      :user
  belongs_to      :survey
  belongs_to      :question_option
  
  attr_protected  :question_option, :survey
  
  alias_method    :option,  :question_option
  alias_method    :option=, :question_option=
  
  scope :from_question, Proc.new { |question| where('question_option_id = ?', question.is_a?(QuestionOption) ? question.id : question) }
  
  validates :user,
    :presence => true,
    :associated => true
  
  validates :question_option,
    :presence => true,
    :associated => true
  
  validates :user_id,
    :uniqueness => { :scope => :question_option_id }
    
  before_save :set_survey
  
  private
  
  def set_survey
    self.survey = option.question.survey
  end
end
