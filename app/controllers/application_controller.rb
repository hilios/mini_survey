# encoding: utf-8
require 'application_responder'

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  protect_from_forgery
  respond_to :html
  
  helper_method :current_user, :authenticated?
  
  protected
  
  def current_user
    @current_user ||= User.find(session[:current_user_id]) if session[:current_user_id]
  end
  
  def sign_in(credentials)
    user = User.find_by_email(credentials[:email])
    if user && user.authenticate(credentials[:password])
      session[:current_user_id] = user.id
      return true
    end
    false
  end
  
  def authenticated?
    !current_user.nil?
  end
  
  def authenticate
    deny_access unless authenticated?
  end
  
  def deny_access
    redirect_to root_path, :notice => "Por favor identifique-se"
  end
end
