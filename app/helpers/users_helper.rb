module UsersHelper
    def lock_status(user)
        if user.access_locked?
            "#{heroicon("lock-open")} Unlock user".html_safe
        else
            "#{heroicon("lock-closed")} Lock user".html_safe
        end
    end

    def lock_status_dialog_confirmation_title(user)
        if user.access_locked?
            "Unlock user"
        else
            "Lock user"
        end
    end

    def lock_status_dialog_confirmation_content(user)
        if user.access_locked?
            "You are about to unlock this user account.<br>Are you sure?".html_safe
        else
            "You are about to lock this user account.<br>Are you sure?".html_safe
        end
    end

    def user_role_color(user)
        if user.roles.first.name == 'admin'
            "primary"
        elsif user.roles.first.name == 'staff'
            "secondary"
        else
            "accent"
        end
    end
end