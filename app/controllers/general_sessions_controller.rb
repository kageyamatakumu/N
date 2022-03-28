class GeneralSessionsController < ApplicationController
  def new
    @general = General.new
  end

  def create
      @general = login(params[:email], params[:password])

      if @general && @general.type == "General"
          redirect_to root_path,  flash: { success: 'ログイン成功' }
      else
          logout
          flash.now[:danger] = "メールアドレス、またはパスワードが違います。再度正しく入力してください。"
          render :new
      end
  end

  def destroy
      logout
      redirect_to root_path
  end
end
