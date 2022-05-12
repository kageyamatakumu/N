class OwnersController < ApplicationController
  def new
    @owner = Owner.new
  end

  def create
    @owner = Owner.new(owener_params)
    if @owner.save
      notifier.ping("新規BRAND「#{@owner.name}」さんが登録しました。")
      redirect_to admin_owner_login_path, success: 'ブランドオーナーアカウント作成'
    else
      render :new
    end
  end

  private

  def owener_params
    params.require(:owner).permit(:name, :email, :password, :password_confirmation)
  end

  def notifier
    Slack::Notifier.new(ENV['Slack'])
  end
end
