class Question < ActiveRecord::Base
  
  belongs_to    :survey
  has_many      :question_options
  
  alias_method  :options,   :question_options
  alias_method  :options=,  :question_options=
  
  scope :from_survey, lambda { |survey| joins(:survey).where('questions.survey_id = ?', survey.is_a?(Integer) ? survey : survey.id) }
  scope :numbered,    order('number ASC')
  
  validates :survey,
    :presence => true,
    :associated => true
  
  validates :number,
    :numericality => { :greater_than => 0, :only_integer => true },
    :unless => Proc.new { |question| question.number.nil? }
  
  validates :title,
    :presence => true
end
