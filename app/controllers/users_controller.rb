class UsersController < ApplicationController
    before_action :set_user, only: [:edit, :update, :destroy]
    before_action :check_user_role, only: [:index]
    
    def index
      @users = User.all
    end

    def show
      @user = User.find(params[:id])
    end
    
    def edit
      unless current_user_can_edit_user?(@user)
        redirect_to root_path, alert: "You are not authorized to perform this action."
      end
    end
    
    def update
      unless current_user_can_edit_user?(@user)
        redirect_to root_path, alert: "You are not authorized to perform this action."
        return
      end
      
      if @user.update(user_params) 
        redirect_to user_path(@user), notice: "User was successfully updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      if current_user_can_edit_user?(@user) && current_user.roles.first.name == 'admin'
        @user.destroy
        redirect_to users_path, notice: "User was successfully deleted."
      elsif current_user_can_edit_user?(@user) && current_user.roles.first.name != 'admin'
        @user.destroy
        redirect_to user_session_path, notice: "User was successfully deleted."
      else
        redirect_to user_session, alert: "You are not authorized to perform this action."
      end
    end
    
    private
    
    def set_user
      @user = User.find(params[:id])
    end
    
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, { role_ids: [] })
    end
    
    def current_user_can_edit_user?(user)
        current_user.roles.first.name == 'admin' || 
        (current_user == user && current_user.roles.first.name != 'admin')
    end

    def check_user_role
        if current_user.roles.first.name == 'staff' || current_user.roles.first.name == 'client'
            redirect_to root_path, alert: "You are not authorized to view this page."
        end
    end
  end