class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :validatable

  validates :first_name, :last_name, presence: true

  has_many :permissions,        dependent: :destroy
  has_many :roles,              through: :permissions

  has_many :active_permissions, -> { where(active: true) }, class_name: 'Permission', inverse_of: :user
  has_many :active_roles,       through: :active_permissions, source: :role

  def generate_jwt
    JWT.encode({ id: id, exp: exp }, Rails.application.secret_key_base)
  end

  private

  def exp
    60.days.from_now.to_i
  end
end
