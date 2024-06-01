class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    
    def require_admin_user_logged_in!
        redirect_to root_path, alert: "Unauthorized access." if current_user.nil? || current_user.roles.first.name != 'admin'
    end

    # Upon Sign Out, redirect user to Sign In page in order to show the proper sign out message.
    def after_sign_out_path_for(resource_or_scope)
        new_user_session_path
    end

    protected
  
    # These are strong parameters for Devise specified for security reasons.
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
      devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name])
    end
end
