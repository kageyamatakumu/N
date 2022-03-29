require 'rails_helper'

RSpec.describe Brand, type: :model do
    describe 'validation' do

        # 全てのカラムが正常に入力
        it '有効(brand)' do
            brand = build(:brand)
            expect(brand).to be_valid
            expect(brand.errors).to be_empty
        end

        # 名前が未入力
        it '無効(without name)' do
            brand = build(:brand, name: "")
            expect(brand).to be_invalid
            expect(brand.errors[:name]).to eq ["を入力してください"]
        end

        # Instagramのユーザーネームが未入力
        it '無効(without instagram_user_name)' do
            brand = build(:brand, instagram_user_name: "")
            expect(brand).to be_invalid
            expect(brand.errors[:instagram_user_name]).to eq ["を入力してください"]
        end

        # Instagramのユーザーネームが重複
        it '無効(duplicate instagram_user_name)' do
            brand = create(:brand)
            brand_duplicate_instagram_user_name = build(:brand, instagram_user_name: brand.instagram_user_name)
            expect(brand_duplicate_instagram_user_name).to be_invalid
            expect(brand_duplicate_instagram_user_name.errors[:instagram_user_name]).to eq ["はすでに存在します"]
        end

        # ブランド立ち上げ日が未入力
        it '無効(without start_up)' do
            brand = build(:brand, start_up: "")
            expect(brand).to be_invalid
            expect(brand.errors[:start_up]).to eq ["を入力してください"]
        end

        # ブランド説明が151文字以上
        it '無効(brand description is over 150 characters)' do
            brand = build(:brand, brand_description: "a"*151)
            expect(brand).to be_invalid
            expect(brand.errors[:brand_description]).to eq ["は150文字以内で入力してください"]
        end
    end
end