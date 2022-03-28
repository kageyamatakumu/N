class OwnersController < ApplicationController
    def new
        @owner = Owner.new
    end

    def create
        @owner = Owner.new(owener_params)

        if @owner.save
            redirect_to admin_owner_login_path, success: 'ブランドオーナーアカウント作成'
        else
            render :new
        end
    end

    private

    def owener_params
        params.require(:owner).permit(:name, :email, :password, :password_confirmation)
    end
end
