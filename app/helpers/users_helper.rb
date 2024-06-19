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
            "Unlock user #{user.email}"
        else
            "Lock user #{user.email}"
        end
    end

    def lock_status_dialog_confirmation_content(user)
        if user.access_locked?
            "Are you sure you want to unlock this user account?"
        else
            "Are you sure you want to lock this user account?"
        end
    end
end