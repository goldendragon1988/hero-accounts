FactoryBot.define do
  factory :permission do
    active { false }
    user { nil }
    role { nil }
  end
end
