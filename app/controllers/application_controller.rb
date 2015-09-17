class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :authenticate_user!
  #before_filter :verify_admin
	#private
	#def verify_admin
	#  redirect_to root_path unless current_user.try(:admin?)
	#end

 
  def after_sign_in_path_for(resource)
	  if current_user.has_role? :admin
	    admin_dashboard_path
	  else
	    #user_path(current_user)
	    courses_path
	  end
  end
end
