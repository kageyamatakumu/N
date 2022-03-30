require 'rails_helper'

RSpec.describe "Brands", type: :system do

    describe 'ブランドの新規登録' do
        let(:owner) { create(:owner) }
        let!(:brand) { create(:brand) }

        context 'フォームの入力値が正常' do
            it 'ブランドの登録が成功する' do
                login_owner(owner)
                visit admin_root_path
                click_on 'ブランド登録'
                visit new_admin_brand_path
                fill_in 'ブランドネーム', with: 'Nemo'
                fill_in 'ブランド説明', with: 'Nemoは新しいブランドを紹介していくプラットフォームです。'
                fill_in 'Instagram ID (ユーザーネーム)', with: 'nemo.fashionsite'
                select_date("2019,9,28", from: "ブランド立ち上げ日(年/月/日)")
                attach_file 'brand[brand_image]', "#{Rails.root}/spec/fixtures/no_image.png"
                attach_file 'brand[instagram_image]', "#{Rails.root}/spec/fixtures/NEMO_logo.jpg"
                click_button '登録'
                expect(page).to have_content 'ブランド情報'
                expect(page).to have_content 'Nemo'
                expect(page).to have_content 'Nemoは新しいブランドを紹介していくプラットフォームです。'
                expect(page).to have_content '2019-09-28'
                expect(page).to have_selector("img[src$='no_image.png']")
                expect(page).to have_selector("img[src$='NEMO_logo.jpg']")
                expect(current_path).to eq '/admin/brands/13' # idが変更される
            end
        end

        context 'ブランド名が未入力' do
            it 'ブランド登録が失敗する' do
                login_owner(owner)
                visit admin_root_path
                click_on 'ブランド登録'
                visit new_admin_brand_path
                fill_in 'ブランドネーム', with: ''
                fill_in 'ブランド説明', with: 'Nemoは新しいブランドを紹介していくプラットフォームです。'
                fill_in 'Instagram ID (ユーザーネーム)', with: 'nemo.fashionsite'
                select_date("2019,9,28", from: "ブランド立ち上げ日(年/月/日)")
                attach_file 'brand[brand_image]', "#{Rails.root}/spec/fixtures/no_image.png"
                attach_file 'brand[instagram_image]', "#{Rails.root}/spec/fixtures/NEMO_logo.jpg"
                click_button '登録'
                expect(page).to have_content 'ブランドネームを入力してください'
                expect(current_path).to eq admin_brands_path
            end
        end

        context 'Instagramのユーザーネームが未入力' do
            it 'ブランド登録が失敗する' do
                login_owner(owner)
                visit admin_root_path
                click_on 'ブランド登録'
                visit new_admin_brand_path
                fill_in 'ブランドネーム', with: 'Nemo'
                fill_in 'ブランド説明', with: 'Nemoは新しいブランドを紹介していくプラットフォームです。'
                fill_in 'Instagram ID (ユーザーネーム)', with: ''
                select_date("2019,9,28", from: "ブランド立ち上げ日(年/月/日)")
                attach_file 'brand[brand_image]', "#{Rails.root}/spec/fixtures/no_image.png"
                attach_file 'brand[instagram_image]', "#{Rails.root}/spec/fixtures/NEMO_logo.jpg"
                click_button '登録'
                expect(page).to have_content 'Instagram ID (ユーザーネーム)を入力してください'
                expect(current_path).to eq admin_brands_path
            end
        end

        context '登録済みのInstagramのユーザーネームを使用' do
            it 'ブランド登録が失敗する' do
                login_owner(owner)
                visit admin_root_path
                click_on 'ブランド登録'
                visit new_admin_brand_path
                fill_in 'ブランドネーム', with: 'Nemo'
                fill_in 'ブランド説明', with: 'Nemoは新しいブランドを紹介していくプラットフォームです。'
                fill_in 'Instagram ID (ユーザーネーム)', with: brand.instagram_user_name
                select_date("2019,9,28", from: "ブランド立ち上げ日(年/月/日)")
                attach_file 'brand[brand_image]', "#{Rails.root}/spec/fixtures/no_image.png"
                attach_file 'brand[instagram_image]', "#{Rails.root}/spec/fixtures/NEMO_logo.jpg"
                click_button '登録'
                expect(page).to have_content 'Instagram ID (ユーザーネーム)はすでに存在します'
                expect(current_path).to eq admin_brands_path
            end
        end

        context 'ブランド説明が151文字以上' do
            it 'ブランド登録が失敗する' do
                login_owner(owner)
                visit admin_root_path
                click_on 'ブランド登録'
                visit new_admin_brand_path
                fill_in 'ブランドネーム', with: 'Nemo'
                fill_in 'ブランド説明', with: 'a'*151
                fill_in 'Instagram ID (ユーザーネーム)', with: 'nemo.fashionsite'
                select_date("2019,9,28", from: "ブランド立ち上げ日(年/月/日)")
                attach_file 'brand[brand_image]', "#{Rails.root}/spec/fixtures/no_image.png"
                attach_file 'brand[instagram_image]', "#{Rails.root}/spec/fixtures/NEMO_logo.jpg"
                click_button '登録'
                expect(page).to have_content 'ブランド説明は150文字以内で入力してください'
                expect(current_path).to eq admin_brands_path
            end
        end
    end

    describe 'ブランドの編集' do
        let(:owner) { create(:owner) }
        let!(:brand) { create(:brand, user: owner) }
        let!(:owner2) { create(:owner) }
        let!(:brand2) { create(:brand, user: owner2) }

        context 'フォームの入力値が正常' do
            it 'ブランドの編集が成功する' do
                login_owner(owner)
                visit admin_root_path
                click_on brand.name
                visit edit_admin_brand_path(brand)
                fill_in 'ブランドネーム', with: 'Nemo'
                fill_in 'ブランド', with: 'Nemoは新しいブランドを紹介していくプラットフォームです。'
                fill_in 'Instagram ID (ユーザーネーム)', with: 'nemo.fashionsite'
                select_date("2019,9,28", from: "ブランド立ち上げ日(年/月/日)")
                attach_file 'brand[brand_image]', "#{Rails.root}/spec/fixtures/no_image.png"
                attach_file 'brand[instagram_image]', "#{Rails.root}/spec/fixtures/NEMO_logo.jpg"
                click_button '編集'
                expect(page).to have_content 'ブランド情報'
                expect(page).to have_content 'Nemo'
                expect(page).to have_content 'Nemoは新しいブランドを紹介していくプラットフォームです。'
                expect(page).to have_content '2019-09-28'
                expect(page).to have_selector("img[src$='no_image.png']")
                expect(page).to have_selector("img[src$='NEMO_logo.jpg']")
                expect(current_path).to eq admin_brand_path(brand)
            end
        end

        context 'フォームが未入力(Instagram ID)' do
            it 'ブランド編集が失敗する' do
                login_owner(owner)
                visit admin_root_path
                click_on brand.name
                visit edit_admin_brand_path(brand)
                fill_in 'ブランドネーム', with: 'Nemo'
                fill_in 'ブランド', with: 'Nemoは新しいブランドを紹介していくプラットフォームです。'
                fill_in 'Instagram ID (ユーザーネーム)', with: ''
                select_date("2019,9,28", from: "ブランド立ち上げ日(年/月/日)")
                attach_file 'brand[brand_image]', "#{Rails.root}/spec/fixtures/no_image.png"
                attach_file 'brand[instagram_image]', "#{Rails.root}/spec/fixtures/NEMO_logo.jpg"
                click_button '編集'
                expect(page).to have_content 'ID (ユーザーネーム)を入力してください'
                expect(current_path).to eq admin_brand_path(brand)
            end
        end

        context '登録済みのInstagramのユーザーネームを使用' do
            it 'ブランド編集が失敗する' do
                login_owner(owner)
                visit admin_root_path
                click_on brand.name
                visit edit_admin_brand_path(brand)
                fill_in 'ブランドネーム', with: 'Nemo'
                fill_in 'ブランド', with: 'Nemoは新しいブランドを紹介していくプラットフォームです。'
                fill_in 'Instagram ID (ユーザーネーム)', with: brand2.instagram_user_name
                select_date("2019,9,28", from: "ブランド立ち上げ日(年/月/日)")
                attach_file 'brand[brand_image]', "#{Rails.root}/spec/fixtures/no_image.png"
                attach_file 'brand[instagram_image]', "#{Rails.root}/spec/fixtures/NEMO_logo.jpg"
                click_button '編集'
                expect(page).to have_content 'Instagram ID (ユーザーネーム)はすでに存在します'
                expect(current_path).to eq admin_brand_path(brand)
            end
        end

        context '他ブランドオーナーのブランド編集ページにアクセス' do
            it '編集ページへのアクセスが失敗する' do
                login_owner(owner)
                visit edit_admin_brand_path(brand2)
                expect(page).to have_content 'アクセス許可できません'
                expect(current_path).to eq sessions_path
            end
        end
    end

end