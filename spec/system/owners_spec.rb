require 'rails_helper'

RSpec.describe "Owners", type: :system do

    let(:owner) { create(:owner) }

    describe 'ログイン前' do
        context '新規登録ができる' do
            it 'オーナーの新規作成ができる' do
                visit root_path
                click_on '無料登録'
                visit acounts_path
                click_on 'ブランドオーナーアカウント作成'
                visit new_owner_path
                fill_in 'オーナーネーム', with: 'Owner'
                fill_in 'メールアドレス', with: 'email@example.com'
                fill_in 'Password', with: 'password'
                fill_in 'Password 再入力', with: 'password'
                click_on '登録'
                expect(page).to have_content 'オーナー様ログイン画面'
                expect(current_path).to eq admin_owner_login_path
            end
        end

        context '名前が未入力' do
            it 'オーナーの新規作成が失敗する' do
                visit new_owner_path
                fill_in 'オーナーネーム', with: ''
                fill_in 'メールアドレス', with: 'email@example.com'
                fill_in 'Password', with: 'password'
                fill_in 'Password 再入力', with: 'password'
                click_on '登録'
                expect(page).to have_content 'オーナーネームを入力してください'
                expect(current_path).to eq owners_path
            end
        end

        context 'メールアドレスが未入力' do
            it 'オーナーの新規作成が失敗する' do
                visit new_owner_path
                fill_in 'オーナーネーム', with: 'Owner'
                fill_in 'メールアドレス', with: ''
                fill_in 'Password', with: 'password'
                fill_in 'Password 再入力', with: 'password'
                click_on '登録'
                expect(page).to have_content 'メールアドレスを入力してください'
                expect(current_path).to eq owners_path
            end
        end

        context '登録済みのメールアドレスを使用' do
            it 'オーナーの新規作成に失敗する' do
                existed_owner = create(:owner)
                visit new_owner_path
                fill_in 'オーナーネーム', with: 'Owner'
                fill_in 'メールアドレス', with: existed_owner.email
                fill_in 'Password', with: 'password'
                fill_in 'Password 再入力', with: 'password'
                click_on '登録'
                expect(page).to have_content 'メールアドレスはすでに存在します'
                expect(current_path).to eq owners_path
            end
        end

        context 'Passwordが未入力' do
            it 'ユーザーの新規作成に失敗する' do
                visit new_owner_path
                fill_in 'オーナーネーム', with: 'Owner'
                fill_in 'メールアドレス', with: 'email@example.com'
                fill_in 'Password', with: ''
                fill_in 'Password 再入力', with: ''
                click_on '登録'
                expect(page).to have_content 'Passwordは3文字以上で入力してください'
                expect(current_path).to eq owners_path
            end
        end

        context 'Password_confirmが未入力' do
            it 'ユーザーの新規作成に失敗する' do
                visit new_owner_path
                fill_in 'オーナーネーム', with: 'Owner'
                fill_in 'メールアドレス', with: 'email@example.com'
                fill_in 'Password', with: 'password'
                fill_in 'Password 再入力', with: ''
                click_on '登録'
                expect(page).to have_content 'Password 再入力とPasswordの入力が一致しません'
                expect(current_path).to eq owners_path
            end
        end

        context 'PasswordとPassword_confirmが一致しない' do
            it 'ユーザーの新規作成に失敗する' do
                visit new_owner_path
                fill_in 'オーナーネーム', with: 'Owner'
                fill_in 'メールアドレス', with: 'email@example.com'
                fill_in 'Password', with: 'password'
                fill_in 'Password 再入力', with: 'pass'
                click_on '登録'
                expect(page).to have_content 'Password 再入力とPasswordの入力が一致しません'
                expect(current_path).to eq owners_path
            end
        end
    end
end