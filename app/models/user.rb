class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # Associations
  has_many :complaints

  # Devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Constants for roles
  ROLES = %w[authority normal_user]

  # Validation for role to make sure only valid roles are assigned
  validates :role, inclusion: { in: ROLES }

  # Methods to check roles
  def authority?
    role == 'authority'
  end

  def normal_user?
    role == 'normal_user'
  end

  # Optional: Add a setter method to set the role more easily
  def assign_role(role)
    if ROLES.include?(role)
      update(role: role)
    else
      errors.add(:role, 'Invalid role')
    end
  end
end
