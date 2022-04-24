require 'rails_helper'

RSpec.describe "GeneralSessions", type: :system do

  let!(:general){ create(:general) }
  let!(:owner){ create(:owner) }

  describe 'ログイン前' do
    context 'フォームの入力値が正常' do
      it 'ログイン処理が成功する' do
        visit general_login_path
        fill_in 'メールアドレス', with: general.email
        fill_in 'Password', with: '12345678'
        click_button 'ログイン'
        expect(page).to have_content 'ログイン成功'
        expect(current_path).to eq root_path
      end
    end

    context 'フォームが未入力' do
      it 'ログイン処理が失敗する' do
        visit general_login_path
        fill_in 'メールアドレス', with: ''
        fill_in 'Password', with: '12345678'
        click_button 'ログイン'
        expect(page).to have_content 'メールアドレス、またはパスワードが違います。再度正しく入力してください。'
        expect(current_path).to eq general_login_path
      end
    end

    context 'ビジネスオーナーがログインを試みる' do
      it 'ログインが失敗する' do
        visit general_login_path
        fill_in 'メールアドレス', with: owner.email
        fill_in 'Password', with: '12345678'
        click_button 'ログイン'
        expect(page).to have_content 'メールアドレス、またはパスワードが違います。再度正しく入力してください。'
        expect(current_path).to eq general_login_path
      end
    end
  end

  # fontawesomeの見つけ方？
  describe 'ログイン後' do
    context 'ログアウトボタンをクリック' do
      it 'ログアウト処理が成功する' do
        login_as(general)
        click_on 'ログアウト'
        expect(page).to have_content '無料登録'
        expect(current_path).to eq root_path
      end
    end
  end

end