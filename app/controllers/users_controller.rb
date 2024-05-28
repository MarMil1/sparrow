class UsersController < ApplicationController
    before_action :require_admin_user_logged_in!
    
    def index
        @users = User.all
    end

    def edit
        @user = User.find_by(user_params)
    end

    def update
        @user = User.find_by(user_params)

        if @user.update(user_role_params)
            redirect_to users_path, notice: "User was successfully updated."
        else
            render :edit, status: :unprocessable_entity
        end
    end

    private

    def user_params
        params.permit(:id)
    end

    def user_role_params
        params.require(:user).permit({role_ids: []})
    end
end