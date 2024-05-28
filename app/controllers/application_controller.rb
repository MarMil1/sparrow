class ApplicationController < ActionController::Base
    def require_admin_user_logged_in!
        redirect_to root_path, alert: "Unauthorized access." if current_user.roles.first.name != 'admin'
    end
end
