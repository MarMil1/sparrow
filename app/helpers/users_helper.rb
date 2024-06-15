module UsersHelper
    def lock_status(user)
        if user.access_locked?
            "#{heroicon("lock-open")} Unlock user account".html_safe
        else
            "#{heroicon("lock-closed")} Lock user account".html_safe
        end
    end
end