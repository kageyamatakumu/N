FactoryBot.define do
  factory :general do
    name {"test"}
    sequence(:email) { |n| "user_#{n}@example.com" }
    password {"12345678"}
    password_confirmation {"12345678"}
  end
end