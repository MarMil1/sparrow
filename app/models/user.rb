class User < ApplicationRecord
  rolify

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :trackable

  has_many :invitations, class_name: 'User', as: :invited_by

  after_create :assign_default_role, unless: :invited?

  validates :first_name, :last_name, presence: true

  def assign_default_role
    if admin_user_credentials_valid?
      self.add_role(:admin)
    elsif staff_user_credentials_valid?
      self.add_role(:staff)
    else
      self.add_role(:client)
    end
  end

  def role=(role_name)
    self.roles = [Role.find_by(name: role_name)]
  end

  # Define available roles
  def self.available_roles
    %w[admin staff client]
  end

  private

  def admin_user_credentials_valid?
    admin_users_credentials = Rails.application.credentials.admin_users
    admin_users_credentials.each do |admin|
      user_email = admin[:email]
      user_password = admin[:password]
      return true if self.email == user_email && self.valid_password?(user_password)
    end
    false
  end

  def staff_user_credentials_valid?
    staff_users_credentials = Rails.application.credentials.staff_users
    staff_users_credentials.each do |staff|
      user_email = staff[:email]
      user_password = staff[:password]
      return true if self.email == user_email && self.valid_password?(user_password)
    end
    false
  end

  def invited?
    invitation_token.present?
  end
end