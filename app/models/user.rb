class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :trackable
  
  after_create :assign_default_role

  validate :validate_single_role

  validates :first_name, :last_name, presence: true

  def validate_single_role
    if self.roles.count > 1
      errors.add(:roles, "User can only have one role.")
    end
  end

  def assign_default_role
    # if the user form does not match Staff or Admin information
    if admin_user_credentials_valid?
      self.add_role(:admin)
    elsif staff_user_credentials_valid?
      self.add_role(:staff)
    else
      self.add_role(:client)
    end
  end

  private

  def admin_user_credentials_valid?
    admin_users_credentials = Rails.application.credentials.admin_users
    admin_users_credentials.each do |admin|
      user_email = admin[:email]
      user_password = admin[:password]

      return true if self.email == user_email && self.valid_password?(user_password)
    end

    return false
  end

  def staff_user_credentials_valid?
    staff_users_credentials = Rails.application.credentials.staff_users
    staff_users_credentials.each do |staff|
      user_email = staff[:email]
      user_password = staff[:password]
      
      return true if self.email == user_email && self.valid_password?(user_password)
    end

    return false
  end
  
end
