class Answer < ActiveRecord::Base
  belongs_to      :user
  belongs_to      :question_option
  
  attr_protected  :question_option
  
  alias_method :option,  :question_option
  alias_method :option=, :question_option=
  
  validates :user,
    :presence => true,
    :associated => true

  validates :question_option,
    :presence => true,
    :associated => true
end
