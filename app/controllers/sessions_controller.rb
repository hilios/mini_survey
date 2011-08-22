class SessionsController < ApplicationController
  respond_to :html
  
  def new
    redirect_to user_url(current_user) if authenticated?
    @user = User.new
  end

  def create
    @user = User.find_by_email(params[:user][:email])
    if @user && @user.authenticate(params[:user][:password])
      session[:current_user_id] = @user.id
      redirect_to user_url(@user)
    else
      @user = User.new(:email => params[:user][:email])
      render :new
    end
  end

  def destroy
    session[:current_user_id] = nil
    redirect_to root_url
  end

end
