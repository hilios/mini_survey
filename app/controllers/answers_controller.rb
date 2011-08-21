class AnswersController < ApplicationController
  def index
    @answers = Answer.all
    respond_with @answers
  end

  def show
    @answer = Answer.find(params[:id])
    respond_with @answer
  end

  def new
    @answer = Answer.new
    respond_with @answer
  end

  def edit
    @answer = Answer.find(params[:id])
    respond_with @answer
  end

  def create
    @answer = Answer.new(params[:answer])
    @answer.save
    respond_with @answer
  end

  def update
    @answer = Answer.find(params[:id])
    @answer.update_attributes(params[:answer])
    respond_with @answer
  end

  def destroy
    @answer = Answer.find(params[:id])
    @answer.destroy
    respond_with @answer
  end
end
