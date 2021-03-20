class UserDecorator < SimpleDelegator

  def full_name
    "#{first_name} #{last_name}"
  end

  def me
    __getobj__
  end
end
