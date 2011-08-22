class UsersController < ApplicationController
  before_filter :authenticate,  :except => [:new, :create]
  after_filter  :authorize,     :only => [:edit, :update, :destroy]
  
  def index
    redirect_to current_user
  end

  def show
    @user = User.find(params[:id])
    respond_with @user
  end

  def new
    @user = User.new
    respond_with @user
  end

  def edit
    @user = User.find(params[:id])
    respond_with @user
  end

  def create
    @user = User.new(params[:user])
    @user.save
    respond_with @user do |format|
      format.html { sign_in(params[:user]); redirect_to root_url } if @user.valid?
    end
  end

  def update
    @user = User.find(params[:id])
    @user.update_attributes(params[:user])
    respond_with @user
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    respond_with @user
  end
  
  private
  
  def authorize
    deny_access unless current_user.id == @user.id
  end
end
