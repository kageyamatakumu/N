FactoryBot.define do
    factory :item do
        name { "ジャケット" }
        description{  "こちらの商品は革でできています。"}
        item_image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/no_image.png')) }
        dress_images { [Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/no_image.png'))]}
        association :brand
    end
end