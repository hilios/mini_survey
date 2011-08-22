class SurveysController < ApplicationController
  before_filter :authenticate
  after_filter  :authorize, :only => [:edit, :update, :destroy]
  
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
    2.times { @survey.questions.build }
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
    
  end
end
