class Admin::OwnerSessionsController < Admin::BaseController
  layout 'admin/layouts/admin_login'
  skip_before_action :require_login, only: %i[new create]
  skip_before_action :check_owner, only: %i[new create]

  def new
    @owner = Owner.new
  end

  def create
    @owner = login(params[:email], params[:password])
    if @owner && @owner.type == "Owner"
      redirect_to admin_root_path, flash: { success: 'ログイン成功' }
    else
      logout
      flash.now[:danger] = "メールアドレス、またはパスワードが違います。再度正しく入力してください。もしくは権限がありません。"
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_path
  end

end
