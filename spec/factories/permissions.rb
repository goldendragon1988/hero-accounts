FactoryBot.define do
  factory :permission do
    active { false }
    association :user, factory: :user, strategy: :create
    association :role, factory: :role, strategy: :create
  end
end
