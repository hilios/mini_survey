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
  
  def authenticated?
    !current_user.nil?
  end
  
  def authenticate
    deny_access unless authenticated?
  end
  
  def deny_access
    redirect_to root_url, :notice => "Você foi desconectado com successo"
  end
end
