class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  def after_sign_in_path_for(resource)
    if resource.authority?
      authority_dashboard_path
    elsif resource.normal_user?
      normal_user_dashboard_path
    else
      root_path
    end
  end

  def after_sign_out_path_for(resource)
    root_path 
  end
end
