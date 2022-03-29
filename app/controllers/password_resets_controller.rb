class PasswordResetsController < ApplicationController

    def new
    end
  
    def create
      @user = User.find_by_email(params[:email])
      @user&.deliver_reset_password_instructions!
      redirect_to sessions_path, success: 'メール送信'
    end
  
    def edit
      @token = params[:id]
      @user = User.load_from_reset_password_token(@token)
      not_authenticated if @user.blank?
    end
  
    def update
      @token = params[:id]
      @user = User.load_from_reset_password_token(@token)
  
      return not_authenticated if @user.blank?
  
      if Owner == @user.class
        @user.password_confirmation = params[:owner][:password_confirmation]
        if @user.change_password(params[:owner][:password])
          redirect_to sessions_path, success: 'パスワードを変更しました'
        else
          flash.now[:danger] = 'パスワードを変更できませんでした'
          render :edit
        end
      end
  
      if General == @user.class
        @user.password_confirmation = params[:general][:password_confirmation]
        if @user.change_password(params[:general][:password])
          redirect_to sessions_path, success: 'パスワードを変更しました'
        else
          flash.now[:danger] = 'パスワードを変更できませんでした'
          render :edit
        end
      end
  
    end
  end