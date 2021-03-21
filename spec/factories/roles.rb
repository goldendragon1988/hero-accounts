FactoryBot.define do
  factory :role do
    name { "admin" }

    trait :recruiter do
      name { 'recruiter' }
    end
  end
end
