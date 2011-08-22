class ChoicesController < ApplicationController
  def index
    @options = Choice.all
    respond_with @options
  end

  def show
    @option = Choice.find(params[:id])
    respond_with @option
  end

  def new
    @option = Choice.new
    respond_with @option
  end

  # GET /question_options/1/edit
  def edit
    @option = Choice.find(params[:id])
    respond_with @option
  end

  def create
    @option = Choice.new(params[:question_option])
    @option.save
    respond_with @option
  end

  def update
    @option = Choice.find(params[:id])
    @option.update_attributes(params[:question_option])
    respond_with @option
  end

  def destroy
    @option = Choice.find(params[:id])
    @option.destroy
    respond_with @option
  end
end
