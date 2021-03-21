class BaseProcessor
  extend ActiveModel::Naming

  attr_reader :user

  def initialize(user, _options = {})
    @user = user
  end

  def errors
    @errors ||= ActiveModel::Errors.new(self)
  end
end
