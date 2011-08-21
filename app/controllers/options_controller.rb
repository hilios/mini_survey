class OptionsController < ApplicationController
  def index
    @options = QuestionOption.all
    respond_with @options
  end

  def show
    @option = QuestionOption.find(params[:id])
    respond_with @option
  end

  def new
    @option = QuestionOption.new
    respond_with @option
  end

  # GET /question_options/1/edit
  def edit
    @option = QuestionOption.find(params[:id])
    respond_with @option
  end

  def create
    @option = QuestionOption.new(params[:question_option])
    @option.save
    respond_with @option
  end

  def update
    @option = QuestionOption.find(params[:id])
    @option.update_attributes(params[:question_option])
    respond_with @option
  end

  def destroy
    @option = QuestionOption.find(params[:id])
    @option.destroy
    respond_with @option
  end
end
