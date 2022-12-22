class ApplicationController < ActionController::Base

  def after_sign_out_path_for(resource) 
    new_admin_session_path 
  end
end
