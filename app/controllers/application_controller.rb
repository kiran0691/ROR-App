class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
   before_action :session_verify

   def session_verify
     if session[:user_id].blank?
       render login_users_path
     end
   end
end
