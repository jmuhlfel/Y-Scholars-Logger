class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def after_sign_in_path_for(resource)
    puts "THIS IS ONLY A TEST OK (application controller)"
  end

end
