require 'rails_helper'

RSpec.describe "OwnerSessions", type: :system do

    let!(:general){ create(:general) }
    let!(:owner){ create(:owner) }

    describe 'ログイン前' do
        context 'フォームの入力値が正常' do
            it 'ログイン処理が成功する' do
                visit root_path
                click_on 'ログイン'
                visit sessions_path
                click_button 'ログイン(ブランドオーナー)'
                visit admin_owner_login_path
                fill_in 'メールアドレス', with: owner.email
                fill_in 'Password', with: '12345678'
                click_button 'ログイン'
                expect(page).to have_content '管理画面です'
                expect(current_path).to eq admin_root_path
            end
        end

        context 'フォームが未入力' do
            it 'ログイン処理が失敗する' do
                visit admin_owner_login_path
                fill_in 'メールアドレス', with: ''
                fill_in 'Password', with: '12345678'
                click_button 'ログイン'
                expect(page).to have_content 'メールアドレス、またはパスワードが違います。再度正しく入力してください。'
                expect(current_path).to eq admin_owner_login_path
            end
        end

        context '一般ユーザーがログインを試みる' do
            it 'ログインが失敗する' do
                visit admin_owner_login_path
                fill_in 'メールアドレス', with: general.email
                fill_in 'Password', with: '12345678'
                click_button 'ログイン'
                expect(page).to have_content 'メールアドレス、またはパスワードが違います。再度正しく入力してください。'
                expect(current_path).to eq admin_owner_login_path
            end
        end
    end

    describe 'ログイン後' do
        context 'ログアウトボタンをクリック' do
            it 'ログアウト処理が成功する' do
                login_owner(owner)
                click_on 'ログアウト'
                expect(page).to have_content 'ログイン'
                expect(current_path).to eq root_path
            end
        end
    end
end