# encoding: utf-8
class UsersController < ApplicationController
  before_filter :authenticate,  :except => [:new, :create]
  before_filter :authorize,     :only => [:edit, :update, :destroy]
  helper_method :authorized?

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
      format.html { sign_in(params[:user]); redirect_to root_path, :notice => 'Seja bem-vindo, agora crie uma pesquisa!' } if @user.valid?
    end
  end

  def update
    @user = User.find(params[:id])
    @user.update_attributes(params[:user])
    respond_with @user do |format|
      format.html { redirect_to @user }
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    respond_with @user do |format|
      format.html { redirect_to :controller => :sessions, :action => :destroy }
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
    @requested_user ||= User.find(params[:id])
    current_user.id == @requested_user.id
  end
end
