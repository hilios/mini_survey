class AnswersController < ApplicationController
  before_filter :find_survey
  before_filter :not_allow_duplicated_answers, :only => :create
  before_filter :authorize, :only => :data
  helper_method :authorized?
  
  def index
  end
  
  def data
  end
  
  def create
    answers = []
    params[:answers].each_value { |choice_id| answers << {:choice => Choice.find(choice_id)} }
    current_user.update_attributes :answers_attributes => answers
    respond_with @survey do |format|
      format.html { redirect_to survey_answers_path(@survey) }
    end
  end
  
  private
  
  def find_survey
    @survey = Survey.find(params[:survey_id])
  end
  
  def authorize
    unless authorized?
      flash[:warning] = 'Você não tem permissão para acessar essa página'
      redirect_to current_user
    end
  end
  
  def authorized?
    current_user.id == @survey.user.id
  end
  
  def not_allow_duplicated_answers
    redirect_to survey_answers_path(@survey) if current_user.answered_survey?(@survey)
  end
  
end
