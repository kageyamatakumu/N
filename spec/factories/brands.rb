FactoryBot.define do
  factory :brand do
    association :user, factory: :owner
    name {"brand"}
    brand_description {"brand"}
    sequence(:instagram_user_name) { |n| "instagram_user#{n}_name"}
    start_up {'2020/10/01'}
    brand_image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/no_image.png')) }
    instagram_image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/no_image.png')) }
  end
end