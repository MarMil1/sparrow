class ApplicationController < ActionController::Base
    def require_admin_user_logged_in!
        redirect_to root_path, alert: "Unauthorized access." if current_user.nil? || current_user.roles.first.name != 'admin'
    end

    # Upon Sign Out, redirect user to Sign In page in order to show the proper sign out message.
    def after_sign_out_path_for(resource_or_scope)
        new_user_session_path
    end
end
