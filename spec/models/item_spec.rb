require 'rails_helper'

RSpec.describe Item, type: :model do
    describe 'validation' do

        # 全てのカラムが正常に入力
        it '有効(item)' do
            item = build(:item)
            expect(item).to be_valid
            expect(item.errors).to be_empty
        end

        # 商品名が未入力
        it '無効(without name)' do
            item = build(:item, name: "")
            expect(item).to be_invalid
            expect(item.errors[:name]).to eq ["を入力してください"]
        end

        # 商品説明が未入力
        it '無効(without description)' do
            item = build(:item, description: "")
            expect(item).to be_invalid
            expect(item.errors[:description]).to eq ["を入力してください"]
        end

        #商品説明が151文字以上
        it '無効(item description is over 150 characters)' do
            item = build(:item, description: "a"*151)
            expect(item).to be_invalid
            expect(item.errors[:description]).to eq ["は150文字以内で入力してください"]
        end

        #商品メイン写真が未入力
        it '無効(without item_image)' do
            item = build(:item, item_image: "")
            expect(item).to be_invalid
            expect(item.errors[:item_image]).to eq ["を入力してください"]
        end

        # 着こなし画像が4枚以上
        it '無効(4 or more dressing images)' do
            item = build(:item, dress_images: [Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/no_image.png'))]*4)
            expect(item).to be_invalid
            expect(item.errors[:dress_images]).to eq ["に添付できる画像は3件までです。"]
        end
    end
end