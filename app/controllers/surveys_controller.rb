class SurveysController < ApplicationController
  before_filter :authenticate
  before_filter :authorize, :only => [:edit, :update, :destroy]
  helper_method :authorized?
  
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
    @survey.save!
    respond_with @survey
  end

  def update
    @survey = Survey.find(params[:id])
    respond_with @survey
  end

  def destroy
    @survey = Survey.find(params[:id])
    @survey.destroy
    respond_with @survey
  end
  
  private
  
  def authorize
    unless authorized?
      flash[:warning] = 'Você não tem permissão para acessar essa página'
      redirect_to current_user
    end
  end
  
  def authorized?
    @requested_survey ||= Survey.find(params[:id])
    current_user.id == @requested_survey.user.id or not @requested_survey.private?
  end
end
