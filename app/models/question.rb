class Question < ActiveRecord::Base
  
  belongs_to    :survey
  has_many      :question_options
  
  alias_method  :options,   :question_options
  alias_method  :options=,  :question_options=
  
  scope :from_survey, lambda { |survey| joins(:survey).where('questions.survey_id = ?', survey.is_a?(Survey) ? survey.id : survey) }
  scope :numbered,    order('number ASC')
  
  validates :survey,
    :presence => true,
    :associated => true
  
  validates :number,
    :numericality => { :greater_than => 0, :only_integer => true },
    :unless => Proc.new { |question| question.number.nil? }
  
  validates :title,
    :presence => true
  
  def total
    Question.
      joins(:question_options => :answers).
      where('question_options.question_id = questions.id').
      where('question_options.id = answers.question_option_id').
      count
  end
end
