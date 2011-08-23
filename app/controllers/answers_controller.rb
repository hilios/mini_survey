class AnswersController < ApplicationController
  before_filter :find_survey, :authorize
  helper_method :authorized?
  
  def index
  end
  
  def create
    respond_with @user do |format|
      
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
  
end
