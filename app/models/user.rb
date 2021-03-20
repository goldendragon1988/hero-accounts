class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :validatable

  validates :first_name, :last_name, presence: true

  def generate_jwt
    JWT.encode({ id: id, exp: exp }, Rails.application.secret_key_base)
  end

  private

  def exp
    60.days.from_now.to_i
  end
end
