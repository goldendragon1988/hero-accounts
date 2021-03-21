FactoryBot.define do
  factory :user do
    first_name { "MyString" }
    last_name  { "MyString" }
    email { "test@dev.com" }
    password   { 'password' }
  end
end
