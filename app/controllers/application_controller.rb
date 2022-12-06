class ApplicationController < ActionController::Base

  def after_sign_in_path(resource)
    binding.pry
    redirect_to rails_admin_path
  end

  def after_sign_out_path_for(resource) 
    new_admin_session_path 
  end
end
