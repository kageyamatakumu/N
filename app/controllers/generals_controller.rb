class GeneralsController < ApplicationController
    def new
        @general = General.new
    end

    def create
        @general = General.new(general_params)

        if @general.save
            redirect_to general_login_path,  flash: { success: '作成成功' }
        else
            render :new
        end
    end

    private

    def general_params
        params.require(:general).permit(:name, :email, :password, :password_confirmation)
    end
end
