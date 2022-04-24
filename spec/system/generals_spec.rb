require 'rails_helper'

RSpec.describe "Generals", type: :system do

  describe 'ログイン前' do
    context '新規登録ができる' do
      it 'ユーザーの新規作成ができる' do
        visit new_general_path
        fill_in 'ユーザーネーム', with: 'General'
        fill_in 'メールアドレス', with: 'email@example.com'
        fill_in 'Password', with: 'password'
        fill_in 'Password 再入力', with: 'password'
        click_on '登録'
        expect(page).to have_content 'ログイン'
        expect(current_path).to eq general_login_path
      end
    end

    context '名前が未入力' do
      it 'ユーザーの新規作成が失敗する' do
        visit new_general_path
        fill_in 'ユーザーネーム', with: ''
        fill_in 'メールアドレス', with: 'email@example.com'
        fill_in 'Password', with: 'password'
        fill_in 'Password 再入力', with: 'password'
        click_button '登録'
        expect(page).to have_content '新規登録'
        expect(page).to have_content 'ユーザーネームを入力してください'
        expect(current_path).to eq generals_path
      end
    end

    context 'メールアドレスが未入力' do
      it 'ユーザーの新規作成が失敗する' do
        visit new_general_path
        fill_in 'ユーザーネーム', with: 'General'
        fill_in 'メールアドレス', with: ''
        fill_in 'Password', with: 'password'
        fill_in 'Password 再入力', with: 'password'
        click_button '登録'
        expect(page).to have_content '新規登録'
        expect(page).to have_content 'メールアドレスを入力してください'
        expect(current_path).to eq generals_path
      end
    end

    context '登録済みのメールアドレスを使用' do
      it 'ユーザーの新規作成に失敗する' do
        existed_general = create(:general)
        visit new_general_path
        fill_in 'ユーザーネーム', with: 'General'
        fill_in 'メールアドレス', with: existed_general.email
        fill_in 'Password', with: 'password'
        fill_in 'Password 再入力', with: 'password'
        click_button '登録'
        expect(page).to have_content '新規登録'
        expect(page).to have_content 'メールアドレスはすでに存在します'
        expect(current_path).to eq generals_path
      end
    end

    context 'Passwordが未入力' do
      it 'ユーザーの新規作成に失敗する' do
        visit new_general_path
        fill_in 'ユーザーネーム', with: 'General'
        fill_in 'メールアドレス', with: 'email@example.com'
        fill_in 'Password', with: ''
        fill_in 'Password 再入力', with: ''
        click_button '登録'
        expect(page).to have_content '新規登録'
        expect(page).to have_content 'Passwordは3文字以上で入力してください'
        expect(current_path).to eq generals_path
      end
    end

    context 'Password_confirmが未入力' do
      it 'ユーザーの新規作成に失敗する' do
        visit new_general_path
        fill_in 'ユーザーネーム', with: 'General'
        fill_in 'メールアドレス', with: 'email@example.com'
        fill_in 'Password', with: 'password'
        fill_in 'Password 再入力', with: ''
        click_button '登録'
        expect(page).to have_content '新規登録'
        expect(page).to have_content 'Password 再入力とPasswordの入力が一致しません'
        expect(current_path).to eq generals_path
      end
    end

    context 'PasswordとPassword_confirmが一致しない' do
      it 'ユーザーの新規作成に失敗する' do
        visit new_general_path
        fill_in 'ユーザーネーム', with: 'General'
        fill_in 'メールアドレス', with: 'email@example.com'
        fill_in 'Password', with: 'password'
        fill_in 'Password 再入力', with: 'pass'
        click_button '登録'
        expect(page).to have_content '新規登録'
        expect(page).to have_content 'Password 再入力とPasswordの入力が一致しません'
        expect(current_path).to eq generals_path
      end
    end
  end

end