require 'rails_helper'

RSpec.describe Role, type: :model do
  describe '#validations' do
    it { expect(subject).to(validate_presence_of(:name)) }
    it { expect(subject).to(validate_inclusion_of(:name).in_array(Role::TYPES)) }
  end
end
