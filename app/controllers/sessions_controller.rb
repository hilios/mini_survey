class SessionsController < ApplicationController
  respond_to :html
  
  def new
    redirect_to user_path(current_user) if authenticated?
    @user = User.new
  end

  def create
    @user = User.new(:email => params[:user][:email])
    if sign_in(params[:user])
      redirect_to user_path(current_user)
    else
      flash.now[:error] = 'Email ou senha inválidos.'
      render :new
    end
  end

  def destroy
    session[:current_user_id] = nil
    redirect_to root_path, :notice => flash[:notice] ? 'Sua conta foi apagada.' : 'Você foi deslogado com sucesso.'
  end

end
