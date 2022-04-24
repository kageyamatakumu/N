FactoryBot.define do
  factory :owner do
    name {"owner"}
    sequence(:email) { |n| "owner_#{n}@example.com" }
    password {"12345678"}
    password_confirmation {"12345678"}
  end
end