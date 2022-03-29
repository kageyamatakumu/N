require 'rails_helper'

RSpec.describe User, type: :model do
    describe 'validation' do

        # 全てのカラムが正常に入力
        it '有効(general_user_information)' do
            user = build(:general )
            expect(user).to be_valid
            expect(user.errors).to be_empty
        end

        it '有効(owner)' do
            user = build(:owner )
            expect(user).to be_valid
            expect(user.errors).to be_empty
        end

        # 名前が未入力
        it '無効(general without name)' do
            user_without_title = build(:general, name: "")
            expect(user_without_title).to be_invalid
            expect(user_without_title.errors[:name]).to eq ["を入力してください"]
        end

        it '無効(owner without name)' do
            user_without_name = build(:owner, name: "")
            expect(user_without_name).to be_invalid
            expect(user_without_name.errors[:name]).to eq ["を入力してください"]
        end

        # Emailが未入力
        it '無効(general without email)' do
            user_without_email = build(:general, email: "")
            expect(user_without_email).to be_invalid
            expect(user_without_email.errors[:email]).to eq ["を入力してください"]
        end

        it '無効(owner without email)' do
            user_without_email = build(:owner, email: "")
            expect(user_without_email).to be_invalid
            expect(user_without_email.errors[:email]).to eq ["を入力してください"]
        end

        # Emailが重複
        it '無効(general duplicate email)' do
            user = create(:general)
            user_duplicate_email = build(:general, email: user.email)
            expect(user_duplicate_email).to be_invalid
            expect(user_duplicate_email.errors[:email]).to eq ["はすでに存在します"]
        end

        it '無効(owner duplicate email)' do
            user = create(:owner)
            user_duplicate_email = build(:owner, email: user.email)
            expect(user_duplicate_email).to be_invalid
            expect(user_duplicate_email.errors[:email]).to eq ["はすでに存在します"]
        end

        # パスワードが未入力
        it '無効(general without password)' do
            user_without_password = build(:general, password: "")
            expect(user_without_password).to be_invalid
            expect(user_without_password.errors[:password]).to eq ["は3文字以上で入力してください"]
        end

        it '無効(owner without password)' do
            user_without_password = build(:owner, password: "")
            expect(user_without_password).to be_invalid
            expect(user_without_password.errors[:password]).to eq ["は3文字以上で入力してください"]
        end

        # パスワードが3文字以下
        it '無効(general not enough password)' do
            user_no_enough_password = build(:general, password: "11")
            expect(user_no_enough_password).to be_invalid
            expect(user_no_enough_password.errors[:password]).to eq ["は3文字以上で入力してください"]
        end

        it '無効(owner not enough password)' do
            user_no_enough_password = build(:owner, password: "11")
            expect(user_no_enough_password).to be_invalid
            expect(user_no_enough_password.errors[:password]).to eq ["は3文字以上で入力してください"]
        end

        # パスワードと再確認が一致しない
        it '無効(general eq password_confirmation)' do
            user_without_password_confirmation = build(:general, password_confirmation: "12")
            expect(user_without_password_confirmation ).to be_invalid
            expect(user_without_password_confirmation .errors[:password_confirmation]).to eq ["とPasswordの入力が一致しません"]
        end

        it '無効(owner eq password_confirmation)' do
            user_without_password_confirmation = build(:owner, password_confirmation: "12")
            expect(user_without_password_confirmation ).to be_invalid
            expect(user_without_password_confirmation .errors[:password_confirmation]).to eq ["とPasswordの入力が一致しません"]
        end

        # パスワード再確認が未入力
        it '無効(general without password_confirmation)' do
            user_without_password_confirmation = build(:general, password_confirmation: "")
            expect(user_without_password_confirmation ).to be_invalid
            expect(user_without_password_confirmation .errors[:password_confirmation]).to eq ["とPasswordの入力が一致しません", "を入力してください"]
        end

        it '無効(owner without password_confirmation)' do
            user_without_password_confirmation = build(:owner, password_confirmation: "")
            expect(user_without_password_confirmation ).to be_invalid
            expect(user_without_password_confirmation .errors[:password_confirmation]).to eq ["とPasswordの入力が一致しません", "を入力してください"]
        end
    end
end