require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#validations' do
    it { expect(subject).to(validate_presence_of(:first_name)) }
    it { expect(subject).to(validate_presence_of(:last_name)) }
  end
end
