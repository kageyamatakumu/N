require 'rails_helper'

RSpec.describe "Items", type: :system do

  let(:owner) { create(:owner) }
  let!(:brand){ create(:brand, user: owner) }

  before { login_owner(owner) }

  describe 'アイテムの新規登録' do
    context 'アイテムの登録が成功する' do
      it 'アイテムの登録が成功する' do
        visit admin_root_path
        click_on 'アイテム'
        visit admin_brand_items_path(brand)
        click_on 'アイテム登録'
        visit new_admin_brand_item_path(brand)
        fill_in 'item[name]', with: 'Tシャツ'
        fill_in 'item[description]', with: '白色です。'
        attach_file 'item[item_image]', "#{Rails.root}/spec/fixtures/no_image.png"
        # コーディネート写真のテストは改めて行う。
        click_on 'アイテムを登録する'
        expect(page).to have_content 'アイテム情報'
        expect(page).to have_content 'Tシャツ'
        expect(page).to have_content '白色です。'
        expect(page).to have_selector("img[src$='no_image.png']")
        # URL(item.id)が変動する
        expect(current_path).to eq "/admin/brands/#{brand.id}/items/20"
      end
    end

    context 'アイテム名が未入力' do
      it 'アイテム登録が失敗する' do
        visit admin_root_path
        click_on 'アイテム'
        visit admin_brand_items_path(brand)
        click_on 'アイテム登録'
        visit new_admin_brand_item_path(brand)
        fill_in 'item[name]', with: ''
        fill_in 'item[description]', with: '白色です。'
        attach_file 'item[item_image]', "#{Rails.root}/spec/fixtures/no_image.png"
        click_on 'アイテムを登録する'
        expect(page).to have_content 'アイテム名を入力してください'
        expect(current_path).to eq admin_brand_items_path(brand)
      end
    end

    context 'アイテム説明が未入力' do
      it 'アイテム登録が失敗する' do
        visit admin_root_path
        click_on 'アイテム'
        visit admin_brand_items_path(brand)
        click_on 'アイテム登録'
        visit new_admin_brand_item_path(brand)
        fill_in 'item[name]', with: 'Tシャツ'
        fill_in 'item[description]', with: ''
        attach_file 'item[item_image]', "#{Rails.root}/spec/fixtures/no_image.png"
        click_on 'アイテムを登録する'
        expect(page).to have_content 'アイテム説明を入力してください'
        expect(current_path).to eq admin_brand_items_path(brand)
      end
    end

    context 'アイテム説明が151文字以上' do
      it 'アイテム登録が失敗する' do
        visit admin_root_path
        click_on 'アイテム'
        visit admin_brand_items_path(brand)
        click_on 'アイテム登録'
        visit new_admin_brand_item_path(brand)
        fill_in 'item[name]', with: 'Tシャツ'
        fill_in 'item[description]', with: 'a'*151
        attach_file 'item[item_image]', "#{Rails.root}/spec/fixtures/no_image.png"
        click_on 'アイテムを登録する'
        expect(page).to have_content 'アイテム説明は150文字以内で入力してください'
        expect(current_path).to eq admin_brand_items_path(brand)
      end
    end

    context 'メイン写真が未入力' do
      it 'アイテム登録が失敗する' do
        visit admin_root_path
        click_on 'アイテム'
        visit admin_brand_items_path(brand)
        click_on 'アイテム登録'
        visit new_admin_brand_item_path(brand)
        fill_in 'item[name]', with: 'Tシャツ'
        fill_in 'item[description]', with: '白色です。'
        # attach_fileの未設定の仕方がわからなかったので下記で代行
        # attach_file 'item[item_image]', "#{Rails.root}/spec/fixtures/no_image.png"
        click_on 'アイテムを登録する'
        expect(page).to have_content 'メイン写真を入力してください'
        expect(current_path).to eq admin_brand_items_path(brand)
      end
    end

  end

  describe 'アイテム編集' do

    let!(:item) { create(:item, brand: brand)}

    context 'アイテム編集フォームの値が正常' do
      it 'アイテム編集が成功する' do
        visit admin_root_path
        click_on 'アイテム'
        visit admin_brand_items_path(brand)
        click_on '編集'
        visit edit_admin_brand_item_path(item.brand, item)
        fill_in 'item[name]', with: 'Tシャツ'
        fill_in 'item[description]', with: '白色です。'
        attach_file 'item[item_image]', "#{Rails.root}/spec/fixtures/no_image.png"
        click_on 'アイテムを登録する'
        expect(page).to have_content 'アイテム情報'
        expect(page).to have_content 'Tシャツ'
        expect(page).to have_content '白色です。'
        expect(page).to have_selector("img[src$='no_image.png']")
        expect(current_path).to eq admin_brand_item_path(item.brand, item)
      end
    end

    context 'アイテム編集フォームが未入力(アイテムネーム)' do
      it 'アイテム編集が失敗する' do
        visit admin_root_path
        click_on 'アイテム'
        visit admin_brand_items_path(brand)
        click_on '編集'
        visit edit_admin_brand_item_path(item.brand, item)
        fill_in 'item[name]', with: ''
        fill_in 'item[description]', with: '白色です。'
        attach_file 'item[item_image]', "#{Rails.root}/spec/fixtures/no_image.png"
        click_on 'アイテムを登録する'
        expect(current_path).to eq admin_brand_item_path(item.brand, item)
      end
    end

    context '他ブランドオーナーのアイテム編集ページにアクセス' do
      let!(:owner2) { create(:owner) }
      let!(:brand2) { create(:brand, user: owner2) }
      let!(:item2) { create(:item, brand: brand2) }

      it '編集ページへのアクセスが失敗する' do
        visit edit_admin_brand_item_path(item2.brand, item2)
        expect(page).to have_content 'アクセス許可できません'
        expect(current_path).to eq root_path
      end
    end

  end

  # テストコードが書けなかった。また後日
  describe 'アイテム削除' do

    let!(:item) { create(:item, brand: brand)}

    context '自分のアイテム削除' do
      it 'アイテム削除が成功する' do
        visit admin_root_path
        click_on 'アイテム'
        visit admin_brand_items_path(brand)
        click_on '削除'
        page.driver.browser.switch_to.alert.accept
        expect(page).not_to have_content item.name
        expect(current_path).to eq admin_brand_items_path(item.brand)
      end

      it 'アイテム削除しないが成功する' do
        visit admin_root_path
        click_on 'アイテム'
        visit admin_brand_items_path(brand)
        click_on '削除'
        page.driver.browser.switch_to.alert.dismiss
        expect(page).to have_content item.name
        expect(current_path).to eq admin_brand_items_path(item.brand)
      end

      it 'アラートの表示内容を確認する' do
        visit admin_root_path
        click_on 'アイテム'
        visit admin_brand_items_path(brand)
        click_on '削除'
        expect(page.driver.browser.switch_to.alert.text).to eq "【確認】アイテムを削除してもよろしいですか？"
        page.driver.browser.switch_to.alert.dismiss
      end
    end

    context '他ブランドオーナーのアイテム削除' do
      let!(:owner2) { create(:owner) }
      let!(:brand2) { create(:brand, user: owner2) }
      let!(:item2) { create(:item, brand: brand2) }

      it 'アイテム削除が失敗する' do
        visit admin_brand_items_path(brand2)
        click_on '削除'
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content 'アクセス許可できません'
      end
    end
  end

end