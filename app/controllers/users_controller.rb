class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:edit, :update, :destroy, :resend_invitation]
  before_action :check_user_role, only: [:index, :invite, :pending_invitations]
  before_action :require_admin_user_logged_in!, only: [:invite, :send_invitation, :resend_invitation, :pending_invitations]

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
      redirect_to (request.referrer || root_url), notice: "User was successfully updated."
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

  def invite
    @user = User.new
  end

  def send_invitation
    @user = User.invite!(user_params.except(:role), current_user)
    if @user.errors.empty?
      @user.roles = [] # Clear any roles before assigning the new one
      @user.add_role(user_params[:role])
      redirect_to users_path, notice: 'User invitation sent successfully.'
    else
      render :invite
    end
  end

  def resend_invitation
    puts "This is in resend_invitation method in users_controller.rb."
    @user = User.find(params[:id])
    puts "This is after @USER in resend_invitation method in users_controller.rb."
    if @user.created_by_invite? && @user.invitation_accepted? == false
      @user.invite!
      redirect_to (request.referrer || root_url), notice: "User re-invite email was successfully sent."
    else
      redirect_to (request.referrer || root_url), alert: "User is already active."
    end
  end

  def pending_invitations
    @pending_users = User.where(invitation_accepted_at: nil).where.not(invitation_token: nil)
  end

  def lock_user_account
    @user = User.find(params[:id])
    if @user.access_locked?
      @user.unlock_access!
      redirect_to (request.referrer || root_url), notice: "User account is unlocked."
    else
      @user.lock_access!
      redirect_to (request.referrer || root_url), notice: "User account is locked."
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :role)
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