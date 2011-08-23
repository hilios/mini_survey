class SurveysController < ApplicationController
  before_filter :authenticate
  
  before_filter :not_allow_duplicated_answers, 
    :only => [:show]
    
  before_filter :authorize, 
    :only => [:edit, :update, :destroy]
    
  helper_method :authorized?
  
  respond_to :js, 
    :only => :watch
  
  def index
    @surveys = Survey.not_private.all
    respond_with @surveys
  end

  def show
    @survey = Survey.find(params[:id])
    respond_with @survey
  end

  def new
    @survey = Survey.new
    2.times do
      question = @survey.questions.build 
      3.times { question.choices.build }
    end
    respond_with @survey
  end

  def edit
    @survey = Survey.find(params[:id])
    respond_with @survey
  end

  def create
    @survey = Survey.new(params[:survey])
    @survey.user = current_user
    @survey.save
    respond_with @survey do |format|
      format.html { redirect_to @survey }
    end
  end

  def update
    @survey = Survey.find(params[:id])
    @survey.update_attributes(params[:survey])
    respond_with @survey do |format|
      format.html { redirect_to @survey }
    end
  end

  def destroy
    @survey = Survey.find(params[:id])
    @survey.destroy
    respond_with @survey
  end
  
  def watch
    @survey = Survey.find(params[:id])
    if current_user.watches?(@survey)
      current_user.surveys_watched.delete(@survey)
    else
      current_user.update_attributes :watches_attributes => [{:survey => @survey}]
    end
    respond_with @survey do |format|
      format.html { redirect_to current_user }
    end
  end
  
  private
  
  def authorize
    unless authorized?
      flash[:warning] = 'Você não tem permissão para acessar essa página'
      redirect_to current_user
    end
  end
  
  def authorized?
    find_survey
    current_user.id == @requested_survey.user.id or not @requested_survey.private?
  end
  
  def not_allow_duplicated_answers
    find_survey
    redirect_to survey_answers_path(@requested_survey) if current_user.answered_survey?(@requested_survey)
  end
  
  def find_survey
    @requested_survey ||= Survey.find(params[:id])
  end
end
