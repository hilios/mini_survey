# encoding: utf-8
class AnswersController < ApplicationController
  before_filter :authenticate
  
  before_filter :find_survey
  
  before_filter :not_allow_duplicated_answers, 
    :only => :create
    
  before_filter :authorize, 
    :only => :data
  
  before_filter :protect_surveys,
    :only => [:show]
  
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
  
  def deny_authorization
    flash[:warning] = 'Você não tem permissão para acessar essa página'
    redirect_to current_user
  end
  
  def authorize
    deny_authorization unless authorized?
  end
  
  def authorized?
    current_user.id == @survey.user.id
  end
  
  def not_allow_duplicated_answers
    redirect_to survey_answers_path(@survey) if current_user.answered_survey?(@survey)
  end
  
  def protect_surveys
    deny_authorization if find_survey.private? and current_user.id != find_survey.user.id
  end
end
